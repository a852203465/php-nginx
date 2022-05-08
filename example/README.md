# 基于php7-nginx 镜像完成 php容器运行
## 1. 运行
    先执行根目录的build.sh文件生成base 镜像
### 1.1 直接使用镜像运行
    将PHP文件或者目录影射到容器指定目录中， 
    容器目录：/var/www/html
```yaml
version: "3"
services:
  phpinfo:
      image: registry.cn-shenzhen.aliyuncs.com/a852203465/php-nginx:2.0-fmp
      container_name: phpinfo
      volumes:
        - ./phpinfo.php:/var/www/html/phpinfo.php
      ports:
        - 8000:8080
```

### 1.2 产生新的镜像然后运行
    基于`registry.cn-shenzhen.aliyuncs.com/a852203465/php-nginx:2.0-fmp`镜像生成新镜像

#### 1.2.1 Dockerfile 内容
```dockerfile
FROM registry.cn-shenzhen.aliyuncs.com/a852203465/php-nginx:2.0-fmp
ADD phpinfo.php /var/www/html/
```

#### 1.2.2 写docker-compose文件并运行
```yaml
version: "3"
services:
  phpinfo:
      image: a852203465/phpinfo:latest
      container_name: phpinfo
      build:
        context: ./
        dockerfile: Dockerfile
      ports:
        - 8000:8080
```


















