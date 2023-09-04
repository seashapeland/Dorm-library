
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Dorm library</title>
    <link rel="stylesheet" href="index.css">
  </head>
  <body>
      <div class="bigbox">
        <div class="head">
          <p>Dorm library</p>
        </div>
        <form action="/Dorm_library/login" method="post">
          <table>
            <tr>
              <td class="oo">用户名：</td>
              <td><input type="text" placeholder="请输入用户名" id="uname" name="username"></td>
            </tr>
            <tr>
              <td class="qq">登录密码：</td>
              <td><input type="password" placeholder="请输入登录密码" id="pwd" name="password"></td>
            </tr>
          </table><br>

          <button class="reg" onclick="return confirm()">登录</button>
        </form>
      </div>
      <script>
          function confirm () {
              var un = document.querySelector("#uname");
              var pd = document.querySelector("#pwd");
              if (un.value == "" || pd.value == "" ) {
                  alert("输入错误!!!");
              }
          }

      </script>

  </body>
</html>
