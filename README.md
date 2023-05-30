# "Beijing Open Source Chip Research Institute" Training Project (Emulator)

## Run Mario on NEMU

The following commands are tested ubuntu20.04 

```bash
sudo apt install gcc-riscv64-linux-gnu
sudo apt install g++-riscv64-linux-gnu
sudo apt install bison
sudo apt install flex
sudo apt-get install libncurses5-dev
sudo apt-get install libsdl2-dev
sudo apt-get install libsdl1.2-dev
sudo apt-get install libreadline-dev
clone this repo
cd this repo
git submodule update --init
echo "export AM_HOME=$(pwd)/abstract-machine" >> ~/.bashrc  (if you use zsh, then switch to .zshrc)
echo "export NEMU_HOME=$(pwd)/nemu" >> ~/.bashrc  (if you use zsh, then switch to .zshrc)
source ~/.bashrc
cd nemu
make menuconfig
```

Then you will see such an interface:
![image](https://github.com/YinhuaChen-cloud/ysyx-workbench/assets/57990071/f32b355e-27a6-4da3-b7a3-51c0b3c772e9)

Just exit this interface directly (Press Left Key and Enter)

```
cd fceux-am
make ARCH=riscv64-nemu run mainargs=mario
```


