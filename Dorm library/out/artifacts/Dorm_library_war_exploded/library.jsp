<%@ page import="wenjian.upload" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2023/7/29
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dorm library</title>
    <link rel="stylesheet" href="library.css">
    <script>
        // 禁止页面回退
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    </script>
</head>
<body>

    <ul class="context">
        <li>
            <div>📂</div>
            <a>文件名</a>
            <p style="margin-right: 270px">上传者</p>
        </li>
        <%
            String filepath = request.getServletContext().getRealPath("file");

            File directory = new File(filepath);
            File[] files = directory.listFiles();
            HttpSession mysession = request.getSession(false);
            String uname = (String) mysession.getAttribute("username");

            Map<String,String> filedata = new HashMap<>();
            InputStream is = new FileInputStream(request.getServletContext().getRealPath("data/file.txt"));
            InputStreamReader isr = new InputStreamReader(is, "UTF-8");
            BufferedReader br = new BufferedReader(isr);

            File temp = new File(request.getServletContext().getRealPath("data/file.txt"));
            String line = "";
            String[] arrs = null;
            while ((line = br.readLine()) != null && temp.length() != 0) {
                arrs = line.split("=");
                filedata.put(arrs[0],arrs[1]);
            }
            br.close();
            isr.close();
            is.close();
            int sum = 0;
            for(File file:files) {
                sum++;
        %>
        <li>
            <div>📂</div>
            <a href="${pageContext.request.contextPath}/download?fileName=<%=file.getName()%>"><%=file.getName()%></a>
            <button class="again">重命名</button>
            <a class="del" href="/Dorm_library/library.jsp"><button>删除</button></a>
            <p><%=filedata.get(file.getName())%></p>
        </li>


        <%
            }
        %>
    </ul>

    <div class="rename">
        <form method="post" action="" class="form">
            <p>重命名</p>
            <input type="text" id="myname" name="newfilename">
            <input type="submit" value="确认" id="yes">
        </form>
        <button class="cancel2">取消</button>
    </div>

    <script>
        var again1 = document.querySelector(".context").querySelectorAll("li");
        var rename = document.querySelector(".rename");
        var cancel2 = document.querySelector('.cancel2');

        for(let i = 1; i < again1.length; i++) {
            var again = again1[i].querySelector(".again");
            var del = again1[i].querySelector(".del");

            again.addEventListener('click', function() {
                var p1 = again1[i].querySelector("p");
                var thename = "<%=uname%>";
                var a1 = again1[i].querySelector("a");
                var form = document.querySelector(".form");
                form.action = "/Dorm_library/rename?oldfilename=" + a1.innerHTML;

                if (p1.innerHTML.trim() == thename) {
                    rename.style.display = "block";
                } else {
                    alert("您无法重命名他人上传文件!!!");
                }
            });
            var p2 = again1[i].querySelector("p");
            var tname = "<%=uname%>";
            var a2 = again1[i].querySelector("a");
            if (p2.innerHTML.trim() == tname) {
                del.href = "/Dorm_library/delete?deletefilename=" + a2.innerHTML;
            }
            del.addEventListener('click', function () {
                 var p2 = again1[i].querySelector("p");
                 var tname = "<%=uname%>";
                 var a2 = again1[i].querySelector("a");
                 if (p2.innerHTML.trim() != tname) {
                    alert("您无法删除他人上传文件!!!");
                }
            })
        }

        cancel2.addEventListener('click', function() {
            rename.style.display = "none";
        })
        rename.addEventListener('mousedown', function(e) {
            var x = e.pageX - rename.offsetLeft;
            console.log(rename.offsetLeft);
            var y = e.pageY - rename.offsetTop;
            document.addEventListener('mousemove', move);
            function move(e) {
                rename.style.left = e.pageX - x + 'px';
                rename.style.top = e.pageY - y + 'px';
            }
            rename.addEventListener('mouseup', function() {
                document.removeEventListener('mousemove',move);
            })
        })

    </script>




    <div class="new">上传</div>
    <div class="up">
        <p>📂</p>
        <form action="/Dorm_library/upload" method="post" enctype="multipart/form-data">
            <input type="file" id="myfile" name="mywenjian">
            <input type="submit" value="上传" id="myup">
        </form>
        <button class="cancel1">取消</button>
    </div>
    <script>
        var anew = document.querySelector('.new');
        var up = document.querySelector('.up');
        var load = document.querySelector('#myup');
        var cancel1 = document.querySelector('.cancel1');
        anew.addEventListener('click', function() {
            up.style.display = 'block';
        });
        cancel1.addEventListener('click', function() {
            up.style.display = 'none';
        });
        up.addEventListener('mousedown', function(e) {
            var x = e.pageX - up.offsetLeft;
            console.log(up.offsetLeft);
            var y = e.pageY - up.offsetTop;
            document.addEventListener('mousemove', move);
            function move(e) {
                up.style.left = e.pageX - x + 'px';
                up.style.top = e.pageY - y + 'px';
            }
            up.addEventListener('mouseup', function() {
                document.removeEventListener('mousemove',move);
            })
        })

    </script>

    <div class="user">
        <a href="index.jsp">退出登录</a>
        <p>用户: <%=uname%></p>
    </div>
</body>
</html>
