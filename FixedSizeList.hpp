/** FixedSizeList.h
Simple header for a generic fixed sized list using a static array
The list replaces the elements in the order they were added if it is full
last update : 24/10/2011
creation : 24/10/2011
*/
#ifndef HEADER_FIXEDLISIT
#define HEADER_FIXEDLISIT

namespace DMUtils {

    template <typename T>
    class FixedSizeList {
        public:
        FixedSizeList();//no maximum size ; requires a later call to init
        FixedSizeList(size_t size);//specifies maximum size
        ~FixedSizeList();
        void init(size_t size);//inits the list (supposes list hasn't been used before)

        size_t size(void) const;//returns current list's size
        size_t max_size(void) const;//return the maximum number of T the list can hold
        bool isEmpty(void) const;//true if the list is empty
        bool isFull(void) const;//true if the list if full

        T pop_back(void);
        T pop_front(void);
        void push_back(T t);
        void push_front(T t);
        T begin(void) const;
        T end(void) const;
        T get(size_t i);

        T operator[](size_t i);

        private:
        T* _data;
        size_t _first, _last;//respectively indice of the beginning and of the end of the list, except when _stored=0
        size_t _max_size;
        size_t _stored;//size stored
    };
}

#include "FixedSizeList.tpl"

#endif // HEADER_FIXEDLISIT
