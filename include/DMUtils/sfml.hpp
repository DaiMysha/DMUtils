/** sfml.hpp
Author : DaiMysha
https://github.com/DaiMysha

Utility sfml codes

last update : 02/07/2015
creation : 02/07/2015
*/

#ifndef HEADER_DMUTILS_SFML
#define HEADER_DMUTILS_SFML

#include <DMUtils/maths.hpp>
#include <SFML/Graphics.hpp>

namespace DMUtils {
namespace sfml {

    template <typename T>
    T norm2(const sf::Vector2<T>& v);

    template <typename T>
    T norm(const sf::Vector2<T>& v);
	
	template <typename T>
	sf::Vector2<T> dot(const sf::Vector2<T>& a, const sf::Vector2<T>& b);

    template <typename T>
    float getAngleBetweenVectors(const sf::Vector2<T>& o, const sf::Vector2<T>& v);

    ///If you don't know the angle of your base vector use the function with 2 parameters
    ///if you do know this angle pass it to this function, it saves time
    /// rads
    template <typename T>
    sf::Vector2<T> rotate(const sf::Vector2<T>& v, float alpha, float vecRot);

    template <typename T>
    sf::Vector2<T> rotate(const sf::Vector2<T>& v, float alpha);

    ///Rotates the point v around the origin o of alpha degrees
    template <typename T>
    sf::Vector2<T> rotate(const sf::Vector2<T>& v, float alpha, const sf::Vector2<T>& o);

    ///Returns an AABB englobbing all the pixels visible in the selected view on the world coordinates
	inline sf::IntRect getViewInWorldAABB(const sf::View& view) {
        sf::Vector2f p[4];
        sf::Vector2f c = view.getCenter();
        sf::Vector2f s2 = view.getSize()/2.0f;
        float alpha = view.getRotation();
        p[0] = c - s2;
        p[1] = c + sf::Vector2f(s2.x,-s2.y);
        p[2] = c + s2;
        p[3] = c + sf::Vector2f(-s2.x,s2.y);

        for(int i=0;i<4;++i) p[i] = DMUtils::sfml::rotate(p[i],DMUtils::maths::degToRad(-alpha),c);

        float xmin = DMUtils::maths::min(p[0].x,p[1].x,p[2].x,p[3].x);
        float xmax = DMUtils::maths::max(p[0].x,p[1].x,p[2].x,p[3].x);
        float ymin = DMUtils::maths::min(p[0].y,p[1].y,p[2].y,p[3].y);
        float ymax = DMUtils::maths::max(p[0].y,p[1].y,p[2].y,p[3].y);

        return sf::IntRect(sf::Vector2i(xmin,ymin),sf::Vector2i(xmax-xmin,ymax-ymin));
    }

}
}

#include "sfml.tpl"
#endif // HEADER_DMUTILS_SFML
