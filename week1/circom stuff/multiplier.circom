pragma circom 2.0.0;

template Main() {
    signal input x;
    signal input y;
    signal output prod;

    prod <== x*y;
}

component main = Main();

