# openpose-docker
nvida-gpu-openpose-docker
建立openpose docker环境并不容易。尤其是支持GUI显示。
经过测试，cwaffles/openpose是不错的。
但是我们需要docker支持jupyter进行交互，所以对代码进行适当修改。
还有就是下载openpose源代码非常耗时，可以下载在本地，只建立编译openpose的运行环境即可。


```
docker container run -d --name openpose3  --device=/dev/video0:/dev/video0   --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix --ipc=host -it  --net nlink --ip 172.18.0.54    --gpus "device=0"  -v $HOME/work:/workspace openpose /bin/bash -c 'jupyter notebook --no-browser --ip="*" '
```
参数解释：
-v /tmp/.X11-unix:/tmp/.X11-unix \           #共享本地unix端口
-e DISPLAY=unix$DISPLAY \                    #修改环境变量DISPLAY
--device=/dev/video0:/dev/video0    #是为了映射camer设备到镜像里
--privileged #是为了获取访问camera权限 
```
sudo xhost +si:localuser:root 
```
测试docker gui支持的代码
```
import cv2
cv2.namedWindow('hello')
cv2.destroyAllWindows()
```
编译poenpose
```
cd openpose
mkdir build
cd build
cmake -DBUILD_PYTHON=ON .. && make -j `nproc`
```


发现一个非常不错的教程
https://github.com/InfantLab/VASC



https://hub.docker.com/r/cwaffles/openpose


