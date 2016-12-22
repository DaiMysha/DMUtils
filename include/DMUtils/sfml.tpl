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
        return sqrt(norm2(v));
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

	template <typename T>
	T isLeft(const sf::Vector2<T>& p0, const sf::Vector2<T>& p1, const sf::Vector2<T>& p2)
	{
		return ( (p1.x - p0.x) * (p2.y - p0.y) - (p2.x -  p0.x) * (p1.y - p0.y) );
	}

	template <typename T>
	bool contains(const sf::ConvexShape& shape, sf::Vector2<T> point)
	{
		size_t minyi = 0, maxyi = 0;
		T miny = shape.getPoint(0).y;
		T maxy = miny;

		point = point - shape.getPosition();

		for(size_t i = 0; i < shape.getPointCount(); ++i)
		{
			T y = shape.getPoint(i).y;
			if(y < miny)
			{
				minyi = i;
				miny = y;
			}
			else if(y > maxy)
			{
				maxyi = i;
				maxy = y;
			}
		}

		//std::cout << "min/max : " << miny << "/" << maxy << " / " << point.y << std::endl;

		if(point.y < miny || point.y > maxy)
		{
			return false;
		}

		//find the two segments that surround the point in y axis
		//first going right side
		size_t rightSide1 = minyi, leftSide1 = minyi;
		size_t rightSide2 = minyi, leftSide2 = minyi;
		int i = minyi;
		int ip1;
		while(i != maxyi)
		{
			if(i >= shape.getPointCount())
			{
				i = 0;
			}
			ip1 = i+1;
			if(ip1 >= shape.getPointCount())
			{
				ip1 = 0;
			}

			if(point.y > shape.getPoint(i).y && point.y < shape.getPoint(ip1).y)
			{
				rightSide1 = i;
				rightSide2 = ip1;
			}
			++i;
		}

		//leftSide
		i = minyi;
		while(i != maxyi)
		{
			if(i < 0)
			{
				i = shape.getPointCount()-1;
			}
			ip1 = i-1;
			if(ip1 < 0)
			{
				ip1 = shape.getPointCount()-1;
			}

			if(point.y > shape.getPoint(i).y && point.y < shape.getPoint(ip1).y)
			{
				leftSide1 = ip1;
				leftSide2 = i;
			}
			--i;
		}

		return isLeft(shape.getPoint(rightSide1), shape.getPoint(rightSide2), point) >= 0
			&& isLeft(shape.getPoint(leftSide1), shape.getPoint(leftSide2), point) >= 0;
	}
}
}
