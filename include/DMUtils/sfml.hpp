/** sfml.hpp
Author : DaiMysha
https://github.com/DaiMysha

Utility sfml codes

last update : 02/07/2015
creation : 02/07/2015
*/

#ifndef HEADER_DMUTILS_SFML
#define HEADER_DMUTILS_SFML

#include <SFML/Graphics.hpp>

namespace DMUtils {
namespace sfml {

    template <typename T>
    T norm2(const sf::Vector2<T>& v);

    template <typename T>
    float getAngleBetweenVectors(const sf::Vector2<T>& o, const sf::Vector2<T>& v);

    ///If you don't know the angle of your base vector use the function with 2 parameters
    ///if you do know this angle pass it to this function, it saves time
    /// rads
    template <typename T>
    sf::Vector2<T> rotate(const sf::Vector2<T>& v, float alpha, float vecRot);

    template <typename T>
    sf::Vector2<T> rotate(const sf::Vector2<T>& v, float alpha);

    template <typename T>
    sf::Vector2<T> rotate(const sf::Vector2<T>& v, float alpha, const sf::Vector2<T>& o);

}
}

#include "sfml.tpl"
#endif // HEADER_DMUTILS_SFML
