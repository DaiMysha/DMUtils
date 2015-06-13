
#include "FixedSizeList.h"

#include <assert.h>

namespace DMUtils {

	template <typename T>
    FixedSizeList<T>::FixedSizeList() {
        _data=nullptr;
        init(0);
    }

    template <typename T>
    FixedSizeList<T>::FixedSizeList(size_t size) {
        init(size);
    }

    template <typename T>
    FixedSizeList<T>::~FixedSizeList() {
        delete[]_data;
    }

    template <typename T>
    void FixedSizeList<T>::init(size_t size) {
        if(size) _data = new T[size];
        else _data = 0;
        _first = _last = 0;
        _max_size = size;
        _stored = 0;
    }

    template <typename T>
    size_t FixedSizeList<T>::size(void) const {
        return _stored;
    }

    template <typename T>
    size_t FixedSizeList<T>::max_size(void) const {
        return _max_size;
    }

    template <typename T>
    bool FixedSizeList<T>::isEmpty(void) const {
        return _stored==0;
    }

    template <typename T>
    bool FixedSizeList<T>::isFull(void) const {
        return _stored==_max_size;
    }

    template <typename T>
    T FixedSizeList<T>::pop_back(void) {
        assert(!isEmpty());
        T tmp=_data[_last];
        if(_last==0) _last=_max_size-1;
        else --_last;
        if(_stored>0) --_stored;
        return tmp;
    }

    template <typename T>
    T FixedSizeList<T>::pop_front(void) {
        assert(!isEmpty());
        T tmp = _data[_first++];
        if(_first==_max_size) _first=0;
        if(_stored>0) --_stored;
        return tmp;
    }

    template <typename T>
    void FixedSizeList<T>::push_back(T t) {
        if(isEmpty()) {
            _first = _last = 0;
            _data[_first]=t;
            _stored=1;
            return;
        } else if(isFull()) {
            if(++_first==_max_size) _first=0;
        }
        if(++_last==_max_size) _last=0;
        _data[_last]=t;
        if(_stored<_max_size) ++_stored;
    }

    template <typename T>
    void FixedSizeList<T>::push_front(T t) {
        if(isEmpty()) {
            _first = _last = 0;
            _data[_first]=t;
            _stored=1;
            return;
        } else if(isFull()) {
            if(_last==0) _last=_max_size-1;
        }
        if(_first==0) _first=_max_size-1;
        else --_first;
        _data[_first]=t;
        if(_stored<_max_size) ++_stored;
    }

    template <typename T>
    T FixedSizeList<T>::begin(void) const {
        assert(!isEmpty());
        return _data[_first];
    }

    template <typename T>
    T FixedSizeList<T>::end(void) const {
        assert(!isEmpty());
        return _data[_last];
    }

    template <typename T>
    T FixedSizeList<T>::get(size_t i) {
        assert(i>=0&&i<_max_size);
        assert(!isEmpty());
        size_t pos = _first+i;
        while(pos>=_max_size) pos-=_max_size;
        return _data[pos];
    }
}
