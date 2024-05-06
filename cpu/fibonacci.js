function fibonnaci(n) {
    if (n <= 1) return 1;
    return fibonnaci(n - 1) + fibonnaci(n - 2);
}

fibonnaci(45);