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

#define M_PIf       3.14159265358979323846f

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
    struct power;

    template <typename T>
    inline T clamp(const T& val, const T& min, const T& max);

    template <typename T>
    inline T abs(const T& val);

    template <typename T>
    inline int signOf(const T& val);

    template <typename T>
    constexpr inline T degToRad(const T& a);

    template <typename T>
    constexpr inline T radToDeg(const T& a);

	/*
	inline float sqrt(float number) {
		long i;
		float x, y;
		const float f = 1.5F;
		x = number * 0.5F;
		y = number;
		i = * ( long * ) &y;
		i = 0x5f3759df - ( i >> 1 );
		y = * ( float * ) &i;
		y = y * ( f - ( x * y * y ) );
		y = y * ( f - ( x * y * y ) );
		return number * y;
	}
	//*/

}
}

#include "maths.tpl"
#endif // HEADER_DMUTILS_MATH
