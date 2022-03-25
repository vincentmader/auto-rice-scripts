function x()      { echo "Hello world";          }
function around() { echo before; $1; echo after; }

around x
