#include <iostream>

std::pair<int, int> divide(int n, int d);

int main() {
    int n;
    int d;
    std::cin >> n >> d;

    try {
        if (d == 0) {
            throw std::runtime_error{"Деление на 0"};
        }

        auto [q, r] = divide(n, d);
        std::cout << "Целая часть: " << q << '\n';
        std::cout << "Остаток: " << r;
    } catch (std::runtime_error& err) {
        std::cerr << err.what();
    }
}

std::pair<int, int> divide(int n, int d) {
    const bool stateIsNeg = n < 0 ^ d < 0;
    const bool divIsNeg = d < 0;

    n = std::abs(n);
    d = std::abs(d);

    int q = 0;
    while (n >= d) {
        n -= d;
        q++;
    }
    // number became remainder

    if (stateIsNeg) {
        q = -q;
        n = -n;
    }
    if (divIsNeg) {
        n = -n;
    }

    return std::make_pair(q, n);
}
