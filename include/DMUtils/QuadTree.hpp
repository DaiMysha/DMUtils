/** QuadTree.h
Author : DaiMysha
https://github.com/DaiMysha

Generic QuadTree container
*/

#ifndef HEADER_DMUTILS_QUADTREE
#define HEADER_DMUTILS_QUADTREE

#include <DMUtils/physics/AABB.hpp>

#include <memory>
#include <array>
#include <list>
namespace DMUtils {

    template <typename T, int N = 4, typename TYPE = float>
    class QuadTree {
        QuadTree(const QuadTree& other) = delete;
        QuadTree& operator=(const QuadTree& other) = delete;

        public:

            struct Node {
                Node(const physics::AABB<TYPE>& b, const std::shared_ptr<T>& d);
                physics::AABB<TYPE> box;
                std::shared_ptr<T> data;
            };

            QuadTree(TYPE width, TYPE height);
            QuadTree(TYPE left, TYPE top, TYPE width, TYPE height);

            QuadTree(QuadTree&& other) = default;
            QuadTree& operator=(QuadTree&& other) = default;

            template <typename ... Args>
            std::shared_ptr<T> emplace(physics::AABB<TYPE> p, Args ... args);

            template <typename ... Args>
            std::shared_ptr<T> emplace(TYPE x, TYPE y, Args ... args);

            void insert(physics::AABB<TYPE> p, const std::shared_ptr<T>& item);
            void insert(TYPE x, TYPE y, const std::shared_ptr<T>& item);

            bool remove(const std::shared_ptr<T>& item);
            bool remove(const Node& node);
            size_t remove(physics::AABB<TYPE> p);

            void clear();

            size_t size() const;
            void setArea(const physics::AABB<TYPE>& area);

            std::list<QuadTree::Node> query(physics::AABB<TYPE> region) const;
            std::list<std::shared_ptr<T>> data() const;
            std::list<QuadTree::Node> nodeData() const;

        private:
            void _subdivide();
            inline void _insert(physics::AABB<TYPE> p, const std::shared_ptr<T>& item);
            inline void _query(physics::AABB<TYPE> region, std::list<Node>& res) const;
            inline void _getData(std::list<std::shared_ptr<T>>& ans) const;
            inline void _nodeData(std::list<Node>& ans) const;

			QuadTree* _parent;
			std::unique_ptr<QuadTree> _northWest;
			std::unique_ptr<QuadTree> _northEast;
			std::unique_ptr<QuadTree> _southWest;
			std::unique_ptr<QuadTree> _southEast;
			std::list<QuadTree::Node> _data;
			physics::AABB<TYPE> _aabb;
    };

}

#include "QuadTree.tpl"

#endif // HEADER_DMUTILS_QUADTREE
