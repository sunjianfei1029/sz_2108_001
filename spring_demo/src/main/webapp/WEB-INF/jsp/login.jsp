<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户登录</title>
    <script src="/static/js/jquery.min.js"></script>
    <script>
        jQuery(function ($) {
            $("#loginBtn").click(function () {
                $.ajax({
                    url: "/user/login2.do",
                    type: "post",
                    data: {
                        username: $("input[name=username]").val(),
                        password: $("input[name=password]").val()
                    },
                    success(data) {
                        // data: {success:true/false, msg: "后端返回的消息"}
                        if (data.success) {
                            // location:地址栏对象
                            location = "/index.html";
                        } else {
                            alert(data.msg);
                        }
                    }
                })
            })
        })
    </script>
</head>
<body>
    <form action="/user/login.do" method="post">
        账号：<input type="text" name="username" /><br/>
        密码：<input type="text" name="password" /><br/>
        <input type="submit" value="登录" />
    </form>
    <input id="loginBtn" value="ajax登录" type="button" />
</body>
</html>
