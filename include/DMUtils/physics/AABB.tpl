
namespace DMUtils {
namespace physics {

	template <typename UNIT>
	AABB<UNIT>::AABB() : AABB(0,0,0,0) {
	}

	template <typename UNIT>
	AABB<UNIT>::AABB(UNIT l, UNIT t, UNIT w, UNIT h) : left(l), top(t), width(w), height(h) {
	}

	template <typename UNIT>
	bool AABB<UNIT>::collides(const AABB& other) {
		return !( (left > other.left + other.width) || left + width < other.left ||
				   top > other.top + other.height || top + height < other.top );
	}

	template <typename UNIT>
	bool AABB<UNIT>::contains(UNIT x, UNIT y) {
		return !(x < left || x > left + width
				 || y < top || y > top + height);
	}

}
}
