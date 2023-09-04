<%@ page import="wenjian.upload" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
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
    </ul>
    <div class="rename">
        <form action="/Dorm_library/rename">
            <p>重命名</p>
            <input type="text" id="myname" name="newfilename">
            <input type="submit" value="确认" id="yes">
        </form>
        <button class="cancel2">取消</button>
    </div>
    <%
        String filepath = request.getServletContext().getRealPath("file");
        System.out.println(filepath);
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
        int sum = -1;
        for(File file:files) {
            sum++;
//            int ml = file.getName().charAt(0) - '0';
//            String creater = file.getName().substring(1, ml + 1);
//            String realname = file.getName().substring(ml + 1, file.getName().length());

            %>
            <script>
                var context = document.querySelector(".context");
                var newli = document.createElement("li");
                newli.setAttribute("id", <%=sum%>);
                var div = document.createElement("div");
                div.innerHTML = "📂";
                var a = document.createElement("a");
                a.innerText = "<%=file.getName()%>";
                a.setAttribute("href", "${pageContext.request.contextPath}/download?fileName=<%=file.getName()%>");
                console.log(a.getAttribute("href"));
                var btn1 = document.createElement("button");
                var btn2 = document.createElement("button");

                var p = document.createElement("p");
                btn1.innerHTML = "重命名";
                btn2.innerHTML = "删除";

                p.innerHTML = "<%=filedata.get(file.getName())%>";
                btn1.classList.add("again");
                btn2.classList.add("del");

                context.appendChild(newli);
                newli.appendChild(div);
                newli.appendChild(a);
                newli.appendChild(btn1);
                newli.appendChild(btn2);

                newli.appendChild(p);

            </script>
            <script>
                var again1 = document.querySelector(".context").querySelectorAll("li");
                var rename = document.querySelector(".rename");
                var cancel2 = document.querySelector('.cancel2');

                for(let i = 1; i < again1.length; i++) {
                    var again = again1[i].querySelector(".again");
                    again.addEventListener('click', function() {
                        rename.style.display = "block";
                    });
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
            <%
        }
    %>


<%--    <script>--%>
<%--        var str = document.querySelector(".context").querySelectorAll("li");--%>
<%--        console.log(str.length);--%>
<%--        for(let i = 0; i < str.length; i++) {--%>
<%--            let filename2 = str[i].querySelector("a");--%>
<%--            let name = filename2.innerText;--%>
<%--            var hasChinese = /[\u4e00-\u9fa5]/.test(name);--%>
<%--            console.log(name);--%>
<%--            if (hasChinese) {--%>
<%--                if (name.length > 12) {--%>
<%--                    let newname = name.substr(0, 12) + "...";--%>
<%--                    filename2.innerText = newname;--%>
<%--                }--%>
<%--            } else {--%>
<%--                if (name.length > 25) {--%>
<%--                    let newname = name.substr(0, 25) + "...";--%>
<%--                    console.log(newname);--%>
<%--                    filename2.innerText = newname;--%>
<%--                }--%>
<%--            }--%>

<%--        }--%>
<%--    </script>--%>



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
