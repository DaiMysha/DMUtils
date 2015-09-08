/** AABB.h
Author : DaiMysha
https://github.com/DaiMysha

Generic AABB
*/

#ifndef HEADER_DMUTILS_AABB
#define HEADER_DMUTILS_AABB

#include <memory>
#include <array>
#include <list>

namespace DMUtils {
namespace physics {

    template <typename UNIT>
    struct AABB
    {
        UNIT left;
        UNIT top;
        UNIT width;
        UNIT height;

        AABB();
        AABB(UNIT l, UNIT t, UNIT w, UNIT h);

        bool collides(const AABB& other);

        bool contains(UNIT x, UNIT y);
    };

}
}

#include "AABB.tpl"

#endif // HEADER_DMUTILS_AABB
