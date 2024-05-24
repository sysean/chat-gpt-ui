# 使用官方的 Node.js 镜像作为构建阶段的基础镜像
FROM node:22 AS build

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 yarn.lock 并安装依赖
COPY package.json yarn.lock ./
RUN yarn

# 复制应用代码并构建
COPY . .
RUN yarn build-prod

# 使用官方的 Nginx 镜像作为运行阶段的基础镜像
FROM nginx:alpine

# 复制构建结果到 Nginx 的静态文件目录
COPY --from=build /app/dist /usr/share/nginx/html

# 复制自定义的 Nginx 配置文件
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
