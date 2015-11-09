/** sfml.hpp
Author : DaiMysha
https://github.com/DaiMysha

Utility sfml codes

last update : 02/07/2015
creation : 02/07/2015
*/

#include <cmath>

#include <SFML/Graphics.hpp>

namespace DMUtils {
namespace sfml {

    template <typename T>
    T norm2(const sf::Vector2<T>& v) {
        return (v.x*v.x + v.y*v.y);
    }
	
    template <typename T>
    T norm(const sf::Vector2<T>& v) {
        return sqrt(norm2((v.x*v.x + v.y*v.y)));
    }
	
	template <typename T>
	T dot(const sf::Vector2<T>& a, const sf::Vector2<T>& b) {
		return a.x*b.x + a.y*b.y;
	}

    template <typename T>
    float getAngleBetweenVectors(const sf::Vector2<T>& o, const sf::Vector2<T>& v) {
        return -(atan2(static_cast<double>(o.y),static_cast<double>(o.x)) - atan2(static_cast<double>(v.y),static_cast<double>(v.x)));
    }

    ///If you don't know the angle of your base vector use the function with 2 parameters
    ///if you do know this angle pass it to this function, it saves time
    template <typename T>
    sf::Vector2<T> rotate(const sf::Vector2<T>& v, float alpha, float vecRot) {
        float totAngle = alpha + vecRot;
        float n = sqrt(static_cast<float>(norm2<T>(v)));
        return sf::Vector2<T>(static_cast<T>(-sin(totAngle) * n),static_cast<T>(cos(totAngle) * n));
    }

    template <typename T>
    sf::Vector2<T> rotate(const sf::Vector2<T>& v, float alpha) {
        return rotate(v,alpha,getAngleBetweenVectors(sf::Vector2f(0.0f,1.0f),v));
    }

	template <typename T>
	sf::Vector2<T> rotate(const sf::Vector2<T>& v, float alpha, const sf::Vector2<T>& o) {
		return rotate(v-o,alpha)+o;
	}

}
}
