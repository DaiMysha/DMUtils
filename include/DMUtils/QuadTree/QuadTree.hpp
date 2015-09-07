/** QuadTree.h
Author : DaiMysha
https://github.com/DaiMysha

Generic QuadTree container

last update : 07/09/2015
creation : 07/09/2015
*/

#ifndef HEADER_DMUTILS_QUADTREE
#define HEADER_DMUTILS_QUADTREE

namespace DMUtils {
namespace QuadTree {

    template <typename T, int N = 4, typename TYPE = float>
    class QuadTree {
        public:
            template <typename UNIT>
            struct Point {
                UNIT x;
                UNIT y;

                Point(UNIT xx, UNIT yy) : x(xx), y(yy);
            };

            struct Node {
                Point<TYPE> position;
                std::unique_ptr<T> data;
            };

            QuadTree(TYPE width, TYPE height);
            QuadTree(TYPE left, TYPE top, TYPE width, TYPE height);

            QuadTree(const QuadTree& other) = delete;
            QuadTree(QuadTree&& other) = default;

            QuadTree& operator=(const QuadTree& other) = delete;
            QuadTree& operator=(QuadTree&& other) = default;

            template <typename ... Args>
            void emplace(Point<TYPE> p, Args ... args);
            void insert(Point<TYPE> p, T* item);
            void remove(T* item);
            void remove(Point<TYPE> p);
            void clear();

            size_t size() const;

            struct Data
            {
                T* data;
                QuadTree* owner;
                void remove(){owner->remove(data);};
            };

            std::list<Node> query(AABB<TYPE> region);

            std:array<T*,N>& data();
            const std:array<T*,N>& data() const;

        private:
            //externalize this ?
            template <typename UNIT>
            struct AABB
            {
                UNIT left;
                UNIT top;
                UNIT width;
                UNIT height;

                AABB(UNIT l, UNIT t, UNIT w, UNIT h) : left(l), top(t), width(w), height(h) {
                }

                bool collides(const AABB& other) {
                    return !( (left > other.l + other.width) || left + width < other.l ||
                               top > other.top + other.height || top + height < other.top );
                }

                bool contains(Point<UNIT> p) {
                    return !(p.x < left || p.x > left + width
                             || p.y < top || p.y > top + height);
                }
            };
        QuadTree* _father;
        std::unique_ptr<QuadTree> _northWest;
        std::unique_ptr<QuadTree> _northEast;
        std::unique_ptr<QuadTree> _southWest;
        std::unique_ptr<QuadTree> _southEast;
        std::array<Node, N> _data;
        AABB<TYPE> _aabb;

    };


}
}



#endif // HEADER_DMUTILS_QUADTREE
