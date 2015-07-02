/** maths.hpp
Author : DaiMysha
https://github.com/DaiMysha

Utility math codes

last update : 02/07/2015
creation : 02/07/2015
*/

#ifndef HEADER_DMUTILS_MATH
#define HEADER_DMUTILS_MATH

#ifndef M_PI
#define M_PI		3.14159265358979323846
#endif

namespace DMUtils {
namespace maths {

    template <typename T>
    inline const T& min(const T& a, const T& b);

    template <typename T, typename ... Args>
    inline const T& min(const T& a, const T& b, const T& c, const Args& ... args);

    template <typename T>
    inline const T& max(const T& a, const T& b);

    template <typename T, typename ... Args>
    inline const T& max(const T& a, const T& b, const T& c, const Args& ... args);

    template <int N>
    class power;

    template <typename T>
    inline T clamp(const T& val, const T& min, const T& max);

    template <typename T>
    inline T abs(const T& val);

    template <typename T>
    inline int signOf(const T& val);
}
}

#include "maths.tpl"
#endif // HEADER_DMUTILS_MATH
