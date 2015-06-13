#include <iostream>
#include <string>

#include "FixedSizeList.h"

class MyClass {
    public:
    MyClass(int a=0) : _a(a) {}
    //MyClass(const MyClass& c) : _a(c._a) {}
    void print(std::ostream& os) {
        os << _a;
    }

    private:
    int _a;
};

std::ostream& operator<<(std::ostream& os, MyClass& c) {
    c.print(os);
    return os;
}

int main() {

    {
        /*DMUtils::FixedSizeList<std::string> listString;

        listString.init(5);

        std::string s1("1");
        std::string s2("2");
        std::string s3("3");
        std::string s4("4");
        std::string s5("5");
        std::string s6("6");

        listString.push_back(s1);
        listString.push_back(s2);
        listString.push_back(s3);
        listString.push_back(s4);
        listString.push_back(s5);
        listString.push_back(s6);

        for(size_t i=0;i<listString.size();++i) {
            std::cout << listString.get(i) << std::endl;
        }*/
    }
    {
        DMUtils::FixedSizeList<MyClass> mc(5);

        MyClass c1(1);
        MyClass c2(2);
        MyClass c3(3);
        MyClass c4(4);
        MyClass c5(5);
        MyClass c6(6);

        mc.push_back(c1);
        mc.push_back(c2);
        mc.push_back(c3);
        mc.push_back(c4);
        mc.push_back(c5);
        mc.push_back(c6);

        for(size_t i=0;i<mc.size();++i) {
            mc.get(i).print(std::cout);
        }
    }
    return 0;
}
