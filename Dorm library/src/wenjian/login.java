package wenjian;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class login extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uname = new String(req.getParameter("username").getBytes("iso-8859-1"), "utf-8");
        String upwd = new String(req.getParameter("password").getBytes("iso-8859-1"), "utf-8");

        System.out.println(uname);
        System.out.println(upwd);
        HttpSession mysession = req.getSession();
        mysession.setAttribute("username", uname);
        boolean isright = uname == "" || upwd == "" || uname.trim().length() == 0 || upwd.trim().length() == 0;
        if (isright) {
            req.getRequestDispatcher("index.jsp").forward(req,resp);
        } else {
            req.getRequestDispatcher("library.jsp").forward(req,resp);
        }

    }
}
