---
title: flask结合nacos和GraphQL构建微服务
tags:
  - flask
  - nacos
  - graphql
  - 微服务
categories:
  - python
date: 2020-12-17 23:22:38
---



Flask结合nacos和graphql构建微服务

### 准备

```shell
pip install nacos-sdk-python
pip install graphene
```

### Flask结合graphql

```python
from graphene import ObjectType, Field, String,Int
# 自定义的类型
class ItemList(ObjectType):
    class Meta:
        description = "这是返回类型的注释，要放在Meta类中，graphql会显示"
    data = List(Item) # list列表，Item是自定义类型
    total = Int()		# 标量类型
    page = Field(PageInfo)	# PageInfo是自定义类型，自定义类型需要有Field()

class Query(ObjectType):
    
    hello = Field(Result, user_name=String()) # Result是返回结果，name是参数
    itemList = Field(ItemList,a = Int(),b = Int()) # ItemList是返回类型，a和b是传入的参数
    
    def resolve_hello(root, info,user_name):
        return Result(1,"ok")
	def resolve_itemList(root,info,a,b):
        return ItemList()


schema = Schema(query=Query)

def create_app():
    app = Flask(__name__)
    app.add_url_rule('/graphql',  view_func=GraphQLView.as_view('graphql', schema=schema, graphiql=True))
    
    @app.route('/hello', methods=['get'])
    def hello(): # 普通请求
        return "hello"
    return app


if __name__ == '__main__':
    app = create_app()
    ip = getIp()
    print(ip)
    app.run(ip,9099,debug=True)
    # 用如下方式，如果不想出现WARNING: This is a development server. Do not use it in a production deployment.
    # server = pywsgi.WSGIServer((ip, 9099), app)
    # server.serve_forever()
    
# 在ip:9099/graphql下，即可访问
# 在graphql中，请求如下
#{
#	hello(user_name:"tom"){ result }
#}
```



### 注册服务&维持心跳

```python
import time
import nacos
import socket

def getIp():
    hostname = socket.gethostname()
    ip = socket.gethostbyname(hostname)
    return ip

SERVER_ADDRESSES = "1.1.1.1:8848"
NAMESPACE = "public"


client = nacos.NacosClient(SERVER_ADDRESSES, namespace=NAMESPACE, username="nacos", password="nacos")
# 注册实例
client.add_naming_instance("service-hello", ip=utils.getIp(), port="9099")
# 需要不断发送心跳
while True:
    time.sleep(3)
    client.send_heartbeat("service-hello",ip=getIp(),port="9099") # 持续发心跳
```

spring调用python的微服务

```Java
// FeignClient接口
@Service
@FeignClient(name = "service-hello")
public interface AnormalClient {
    @PostMapping(value="/graphql", consumes= MediaType.APPLICATION_JSON_VALUE)
    String graphql(String sql);

    @GetMapping("/hello")
    String hello();
}

// 调用微服务
String name = "tom";
String q = String.format("{ hello(name: '%s'){code }}",name ).replace('\'','"');
JSONObject jsonObject=new JSONObject();
jsonObject.put("query",q);
System.out.println(jsonObject.toJSONString());
String result = anormalClient.graphql(jsonObject.toJSONString());
System.out.println(result);
```



### 遇到的问题

```
There was an unexpected error (type=Internal Server Error, status=500).
message":"Must provide query string."

1 在postman上按照graphql的格式请求可以正常返回结果
2 抓包后发现请求是 content-type:text/plain 格式的。
3 在postman上按照 content-type:application/json格式请求时，可以正常返回结果。
在postman上按照 content-type:text/plain 的格式请求，出现同样错误message":"Must provide query string"，
所以错误原因时请求的content-type格式问题。
4 将请求设置为appllication/json格式只需要修改注解即可：consumes指定content-Type格式。
@PostMapping(value="hello",consumes= MediaType.APPLICATION_JSON_VALUE)
测试通过。
```

