# 代码规范

## 代码目录结构

``` 
├── hack  // 构建或部署目录
│   ├── build   // 构建相关
│   │   ├── server  // 后端代码构建镜像
│   │   └── ui      // 前端代码构建镜像
│   └── kubernetes  // Kubernetes 一键部署资源文件
└── src  // 源码目录
    ├── backend   // 后端代码
    │   ├── client  // 与 Kubernetes 交互 Client
    │   ├── cmd    // 组件启动入口
    │   │   ├── apiserver  // 后台接口组件
    │   │   └── worker   // 后台 bus 组件，用于审计和 Webhook
    │   ├── common // 通用文件
    │   ├── conf // 配置文件
    │   ├── controllers // 控制层
    │   │   ├── auth // 登录相关
    │   │   ├── base  // Controller 父组件
    │   │   ├── kubernetes // kubernetes 资源相关 Controller
    │   │   ├── openapi // 开放平台 Controller
    │   ├── database // 数据库相关操作工具
    │   ├── health // 组件健康检查
    │   ├── initial // 启动初始化准备
    │   ├── models // 业务逻辑层，结构定义以及数据库交互
    │   ├── oauth2 // OAuth2 登录具体实现
    │   ├── plugins // 后端插件代码 
    │   ├── resources // 与 Kubernetes 交互的业务逻辑层，所有与 Kubernetes 交互的逻辑均在此目录
    │   ├── routers // 路由定义
    │   ├── swagger // beego 生成的 Swagger 相关目录
    │   ├── tests // 测试
    │   ├── util // 工具类
    │   ├── views // 视图层
    │   └── workers // worker 相关，主要是审计和 webhook
    │       ├── audit
    │       └── webhook
    ├── frontend // 前端代码
    │   ├── e2e
    │   │   └── src
    │   ├── lib // 前端插件
    │   └── src 
    │       ├── app
    │       │   ├── admin // 管理视图相关代码
    │       │   ├── portal // 用户视图相关代码
    │       │   └── shared // 通用组件代码
    │       ├── assets // 资源文件
    │       │   ├── i18n // 国际化文件
    │       │   └── images
    └── vendor // Glide 生成的 vendor 目录
```

## Git 提交格式

Git commit message 使用统一规范提交代码，添加相应的前缀，并且 message 可以使用一句话描述清楚本次提交的改动，禁止无意义的 commit 信息。

- 后端代码：添加 "backend: " 前缀

- 前端代码：添加 "frontend: " 前缀

- 文档修改：添加 "docs: " 前缀

## 后端 Golang 代码规范

参照 [https://golang.org/doc/effective_go.html](https://golang.org/doc/effective_go.html)

### 格式化规范

Golang 代码使用 goimports 和 gofmt 进行代码格式化

### 行长约定

一行最长不超过 140 个字符，超过的请使用换行展示，尽量保持格式优雅。

### 命名规范

#### 文件名命名规范

用小写，尽量见名思义，看见文件名就可以知道这个文件下的大概内容，对于源代码里的文件，文件名要很好的代表了一个模块实现的功能。

#### 包名

保持 package 的名字和目录保持一致，尽量采取有意义的包名，简短，有意义，尽量和标准库不要冲突。命名尽量不使用分隔符。

#### 接口名

单个函数的接口名以 "er" 作为后缀，如 Reader,Writer 。

``` golang
type Reader interface {
        Read(p []byte) (n int, err error)
}
```

接口的实现则去掉 "er"

``` golang
// File represents an uploaded file.
type File struct {
	Data   multipart.File
	Header *multipart.FileHeader
}

// Read bytes from the file
func (f *File) Read(p []byte) (n int, err error) {
	return f.Data.Read(p)
}
```


#### 变量

- 全局变量：变量名采用驼峰标准，不要使用_来命名变量名，多个变量申明放在一起

> 在函数外部申明必须使用 var,不要采用:=，容易踩到变量的作用域的问题。


- 局部变量：驼峰式，小写字母开头

### 包引用规范

包引用按照以下三类进行分组：
1.系统包依赖
2.外部包依赖
3.自身包依赖

系统包依赖在最前，外部包依赖居中，自身包依赖放置到最后。

```golang
import (
	"encoding/json"
	"fmt"

	"k8s.io/api/core/v1"

	"github.com/Qihoo360/wayne/src/backend/controllers/base"
	"github.com/Qihoo360/wayne/src/backend/models"
)

``` 

> 新版 Goland 已经支持 Go 代码引用自动分组，其他编辑器请查找相应的解决方案。

### 错误处理

错误处理的原则就是不能丢弃任何有返回 err 的调用，不要采用_丢弃，必须全部处理。接收到错误，要么返回 err，要么实在不行就 panic，或者使用 log 记录下来。
error 的信息不要采用大写字母，尽量保持你的错误简短，但是要足够表达你的错误的意思。

- 在逻辑处理中禁用 panic

在 main 包中只有当实在不可运行的情况采用 panic，例如文件无法打开，数据库无法连接导致程序无法 正常运行，但是对于其他的 package 对外的接口不能有 panic，只能在包内采用。

### 注意闭包的调用

在循环中调用函数或者 goroutine 方法，一定要采用显示的变量调用，不要再闭包函数里面调用循环的参数

```golang
	for i := 0; i < limit; i++ {
		go func() { DoSomething(i) }()       // 错误的做法
		go func(i int) { DoSomething(i) }(i) // 正确的做法
	}
```

### 注释规范

注释可以帮我们很好的完成文档的工作，写得好的注释可以方便我们以后的维护。详细的如何写注释可以 参考：
[http://golang.org/doc/effective_go.html#commentary](http://golang.org/doc/effective_go.html#commentary)

### Struct 规范

Struct 定义和初始化格式采用多行：

定义如下：

```golang
type User struct{
    Username  string
    Email     string
}
```

初始化如下：

```golang
u := User{
    Username: "admin",
    Email:    "admin@gmail.com",
}
```

### Defer

defer 在函数 return 之前执行，对于一些资源的回收用 defer 是好的，但也禁止滥用 defer，defer 是需要消耗性能的,所以频繁调用的函数尽量不要使用 defer。

```golang
// Contents returns the file's contents as a string.
func Contents(filename string) (string, error) {
    f, err := os.Open(filename)
    if err != nil {
        return "", err
    }
    defer f.Close()  // f.Close will run when we're finished.

    var result []byte
    buf := make([]byte, 100)
    for {
        n, err := f.Read(buf[0:])
        result = append(result, buf[0:n]...) // append is discussed later.
        if err != nil {
            if err == io.EOF {
                break
            }
            return "", err  // f will be closed if we return here.
        }
    }
    return string(result), nil // f will be closed if we return here.
}
```

### init() 函数

虽然一个 package 里面可以写任意多个 init 函数, 但这无论是对于可读性还是以后的可维护性来说, 我们都强烈建议用户在一个 package 中每个文件只写一个 init 函数.

### test 写法

使用包 package xxx_test 而不污染单元测试的 package.

## 前端代码规范

代码规范定义详见 [https://github.com/Qihoo360/wayne/blob/master/src/frontend/tslint.json](https://github.com/Qihoo360/wayne/blob/master/src/frontend/tslint.json)

规范释义详见 [https://palantir.github.io/tslint/rules/](https://palantir.github.io/tslint/rules/)
