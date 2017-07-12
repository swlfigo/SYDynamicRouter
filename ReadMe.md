# SYDynamicRouter

### OC版动态路由试手实现


 所有ViewController继承 “SYRouterPageViewController” ，ViewController已经继承push, present , pop 方法
 
 优点：无依赖无残留，通俗易懂, 用到的模块只需在Plist注册即可用
 
#### 解释
 
 路由网址格式 SY://goto?type=xxx&pid=xxx
 
 `SY 为URL Scheme ， type 表示是内部URL跳转或者外部URL跳转 ， pid指内部模块编号， 可在项目文件中中注册`

```objectivec

//使用方法
//所需要用的ViewController继承 SYRouterPageViewController

//例子1： 跳转指定名字的模块 （Param指传到下个模块的信息，相互传值）
[self jumpViewControllerWithPageName:@"SYRouterGreyViewController" otherParam:nil animated:YES];


//例子2： 根据路由网址跳内部对应模块
 NSString *url = @"SY://goto?type=inner_app&pid=000003";
    [self jumpViewControllerWithUrlString:url otherParam:@{@"urlParam":url} animated:YES];
    
//例子3： 根据网址跳外部链接
 NSString *url = @"SY://goto?type=outside_web&url=https://www.baidu.com";
    [self jumpViewControllerWithUrlString:url otherParam:@{@"urlParam":url} animated:YES];



```

