# Tristate Gate

Bit Width= 1
|TIME|EN|IN|BUF_IF_0|BUF_IF_1|NOT_IF_0|NOT_IF_1|
|-|-|-|-|-|-|-|
|0|0|0|0|z|1|z|
|10|0|1|1|z|0|z|
|20|1|0|z|0|z|1|
|30|1|1|z|1|z|0|

Bit Width= 2
|TIME|EN|IN|BUF_IF_0|BUF_IF_1|NOT_IF_0|NOT_IF_1|
|-|-|-|-|-|-|-|
|0|0|00|00|zz|11|zz|
|10|0|01|01|zz|10|zz|
|20|0|10|10|zz|01|zz|
|30|0|11|11|zz|00|zz|
|40|1|00|zz|00|zz|11|
|50|1|01|zz|01|zz|10|
|60|1|10|zz|10|zz|01|
|70|1|11|zz|11|zz|00|
