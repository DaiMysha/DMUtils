/** maths.tpl
Author : DaiMysha
https://github.com/DaiMysha

Template code of the utility math codes

last update : 02/07/2015
creation : 02/07/2015
*/

namespace DMUtils {
namespace maths {

    template <typename T>
    inline const T& min(const T& a, const T& b) {
        return a<b?a:b;
    }

    template <typename T, typename ... Args>
    inline const T& min(const T& a, const T& b, const T& c, const Args& ... args) {
        return min(min(a,b),c,args ...);
    }

    template <typename T>
    inline const T& max(const T& a, const T& b) {
        return a>b?a:b;
    }

    template <typename T, typename ... Args>
    inline const T& max(const T& a, const T& b, const T& c, const Args& ... args) {
        return max(max(a,b),c,args ...);
    }


    template <int N>
    class power {
		template <typename T>
		static inline T of(const T& val) {
			return val*power<N-1>::of(val);
		}
	};

	template <>
	class power<0> {
		template <typename T>
		static inline T of(const T& val) {
			return T(1);
		}
	};

    template <typename T>
    inline T clamp(const T& val, const T& min, const T& max) {
		return val<min?min:(val>max?max:val);
	}

    template <typename T>
    inline T abs(const T& val) {
		return val<T(0)?-val:val;
	}

    template <typename T>
    inline int signOf(const T& val) {
		return (T(0)<val)-(val<T(0));
	}

    template <typename T>
    constexpr inline T degToRad(const T& a) {
		return a * T(M_PI) / T(180.0);
	}

    template <typename T>
    constexpr inline T radToDeg(const T& a) {
		return a * T(180.0) / T(M_PI);
	}
}
}
