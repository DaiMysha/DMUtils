
namespace DMUtils {
	
	template <typename T, int N, typename TYPE>
	QuadTree<T,N,TYPE>::Node::Node(const physics::AABB<TYPE>& b, const std::shared_ptr<T>& d) : box(b), data(d) {
	}

    template <typename T, int N, typename TYPE>
	QuadTree<T,N,TYPE>::QuadTree(TYPE width, TYPE height) : QuadTree(0,0,width,height) {
	}

	template <typename T, int N, typename TYPE>
	QuadTree<T,N,TYPE>::QuadTree(TYPE left, TYPE top, TYPE width, TYPE height) {
		_aabb = physics::AABB<TYPE>(left,top,width,height);
	}

	template <typename T, int N, typename TYPE>
	template <typename ... Args>
	std::shared_ptr<T> QuadTree<T,N,TYPE>::emplace(physics::AABB<TYPE> p, Args ... args) {
		std::shared_ptr<T> data(new T(std::forward<Args>(args)...));
		insert(p,data);
		return data;
	}

	template <typename T, int N, typename TYPE>
	template <typename ... Args>
	std::shared_ptr<T> QuadTree<T,N,TYPE>::emplace(TYPE x, TYPE y, Args ... args) {
		std::shared_ptr<T> data(new T(std::forward<Args>(args)...));
		insert(physics::AABB<TYPE>(x,y,0,0),data);
		return data;
	}

	template <typename T, int N, typename TYPE>
	void QuadTree<T,N,TYPE>::insert(physics::AABB<TYPE> p, const std::shared_ptr<T>& item) {
		if(_aabb.collides(p)) _insert(p,item);
	}

	template <typename T, int N, typename TYPE>
	void QuadTree<T,N,TYPE>::insert(TYPE x, TYPE y, const std::shared_ptr<T>& item) {
		insert(physics::AABB<TYPE>(x,y,0,0),item);
	}

	template <typename T, int N, typename TYPE>
	bool QuadTree<T,N,TYPE>::remove(const std::shared_ptr<T>& item) {
		auto it = std::find_if(_data.begin(),_data.end(),[&item](const QuadTree::Node& n) {
			return n.data.get() == item.get();
		});

		if(it != data.end()) {
			_data.erase(it);
			return true;
		}
		if(_northWest) {
			if(_northWest->remove(item)) return true;
			if(_northEast->remove(item)) return true;
			if(_southWest->remove(item)) return true;
			if(_southEast->remove(item)) return true;
		}
		return false;
	}

	template <typename T, int N, typename TYPE>
	bool QuadTree<T,N,TYPE>::remove(const Node& node) {
		auto it = std::find_if(_data.begin(),_data.end(),[&node](const QuadTree::Node& n) {
			return n.data.get() == node.data.get();
		});

		if(it != data.end()) {
			_data.erase(it);
			return true;
		}
		if(_northWest) {
			if(_northWest->_aabb.collides(node.box)) return _northWest->remove(node);
			if(_northEast->_aabb.collides(node.box)) return _northEast->remove(node);
			if(_southWest->_aabb.collides(node.box)) return _southWest->remove(node);
			if(_southEast->_aabb.collides(node.box)) return _southEast->remove(node);
		}
		return false;
	}

	template <typename T, int N, typename TYPE>
	size_t QuadTree<T,N,TYPE>::remove(physics::AABB<TYPE> p) {
		size_t res = 0;
		if(!_aabb.collides(p)) return res;

		_data.remove_if([&res,&p](const Node& n) {
			if(n.box.collides(p)) {
				++res;
				return true;
			}
			return false;
		});

		if(_northWest) {
			res += _northWest->remove(p);
			res += _northEast->remove(p);
			res += _southWest->remove(p);
			res += _southEast->remove(p);
		}

		return res;
	}

	template <typename T, int N, typename TYPE>
	void QuadTree<T,N,TYPE>::clear() {
		if(_northWest) {
			_northWest->clear();
			_northWest.reset(nullptr);

			_northEast->clear();
			_northEast.reset(nullptr);

			_southWest->clear();
			_southWest.reset(nullptr);

			_southEast->clear();
			_southEast.reset(nullptr);
		}
		_data.clear();
	}

	template <typename T, int N, typename TYPE>
	size_t QuadTree<T,N,TYPE>::size() const {
		size_t size = _data.size();
		if(_northWest) size += _northWest->size() + _northEast->size() + _southWest->size() + _southEast->size();
		return size;
	}

	template <typename T, int N, typename TYPE>
	void QuadTree<T,N,TYPE>::setArea(const physics::AABB<TYPE>& area) {
		std::list<Node> nodes = nodeData();

		_aabb = area;
		clear();

		for(Node& n : nodes) {
			if(_aabb.collides(n.box)) insert(n.box,n.data);
		}
	}

	template <typename T, int N, typename TYPE>
	std::list<typename QuadTree<T,N,TYPE>::Node> QuadTree<T,N,TYPE>::query(physics::AABB<TYPE> region) const {
		if(!_aabb.collides(region)) return std::list<Node>();
		std::list<Node> res;
		_query(region,res);
		return res;
	}

	template <typename T, int N, typename TYPE>
	std::list<std::shared_ptr<T>> QuadTree<T,N,TYPE>::data() const {
		std::list<std::shared_ptr<T>> ans;
		_getData(ans);
		return ans;
	}

	template <typename T, int N, typename TYPE>
	std::list<typename QuadTree<T,N,TYPE>::Node> QuadTree<T,N,TYPE>::nodeData() const {
		std::list<Node> ans = _data;
		_nodeData(ans);
		return ans;
	}

	/****************************** PRIVATE ******************************/

	template <typename T, int N, typename TYPE>
	void QuadTree<T,N,TYPE>::_subdivide() {
		float hw = _aabb.width/2.0;
		float hh = _aabb.height/2.0;
		_northWest.reset(new QuadTree<T,N,TYPE>(_aabb.left,_aabb.top,hw,hh));
		_northEast.reset(new QuadTree<T,N,TYPE>(_aabb.left+hw,_aabb.top,hw,hh));
		_southWest.reset(new QuadTree<T,N,TYPE>(_aabb.left,_aabb.top+hh,hw,hh));
		_southEast.reset(new QuadTree<T,N,TYPE>(_aabb.left+hw,_aabb.top+hh,hw,hh));

		std::list<Node> tmp = _data;
		_data.clear();
		for(auto& it : tmp) {
			insert(it.box,it.data);
		}
	}

	template <typename T, int N, typename TYPE>
	void QuadTree<T,N,TYPE>::_insert(physics::AABB<TYPE> p, const std::shared_ptr<T>& item) {

		if(_northWest) { //already subdivided once
			QuadTree<T,N,TYPE>* target = this;
			int insertCount = 0;

			if(_northWest->_aabb.collides(p)) {
				++insertCount;
				target = _northWest.get();
			}
			if(_northEast->_aabb.collides(p)) {
				++insertCount;
				target = _northEast.get();
			}
			if(_southWest->_aabb.collides(p)) {
				++insertCount;
				target = _southWest.get();
			}
			if(_southEast->_aabb.collides(p)) {
				++insertCount;
				target = _southEast.get();
			}
			
			if(insertCount == 1) { //only one node wants it
				target->insert(p,item);
				return;
			} else { //collides with several children, keep here
				_data.emplace_back(Node(p,item));
				return;
			}
		}

		_data.emplace_back(Node(p,item));
		if(_data.size() > N) {
			_subdivide();
		}
	}

	template <typename T, int N, typename TYPE>
	void QuadTree<T,N,TYPE>::_query(physics::AABB<TYPE> region, std::list<Node>& res) const {

		for(auto& n : _data) {
			if(n.box.collides(region)) res.push_back(n);
		}

		if(_northWest) {
			if(_northWest->_aabb.collides(region)) _northWest->_query(region,res);
			if(_northEast->_aabb.collides(region)) _northEast->_query(region,res);
			if(_southWest->_aabb.collides(region)) _southWest->_query(region,res);
			if(_southEast->_aabb.collides(region)) _southEast->_query(region,res);
		}
	}
	template <typename T, int N, typename TYPE>
	void QuadTree<T,N,TYPE>::_getData(std::list<std::shared_ptr<T>>& ans) const {
		for(const Node& node : _data)
			ans.emplace_back(node.data);

		if(_northWest) {
			_northWest->_getData(ans);
			_northEast->_getData(ans);
			_southWest->_getData(ans);
			_southEast->_getData(ans);
		}
	}

	template <typename T, int N, typename TYPE>
	void QuadTree<T,N,TYPE>::_nodeData(std::list<Node>& ans) const {
		ans.insert(ans.end(),_data.begin(),_data.end());

		if(_northWest) {
			_northWest->_nodeData(ans);
			_northEast->_nodeData(ans);
			_southWest->_nodeData(ans);
			_southEast->_nodeData(ans);
		}
	}
}
