# "一生一芯"工程项目

这是"一生一芯"的工程项目. 通过运行
```bash
bash init.sh subproject-name
```
进行初始化, 具体请参考[实验讲义][lecture note].

[lecture note]: https://docs.ysyx.org/schedule.html

# "Beijing Open Source Chip Research Institute" Training Project

## Run Mario on NEMU

The following commands are tested ubuntu22.04

```bash
sudo apt install gcc-riscv64-linux-gnu
sudo apt install g++-riscv64-linux-gnu
clone this repo
cd this repo
git submodule update --init
echo "export AM_HOME=$(pwd)/abstract-machine" >> ~/.bashrc  (if you use zsh, then switch to .zshrc)
echo "export NEMU_HOME=$(pwd)/nemu" >> ~/.bashrc  (if you use zsh, then switch to .zshrc)
cd fceux-am
make ARCH=riscv64-nemu run mainargs=mario
```


