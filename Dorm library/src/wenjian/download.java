package wenjian;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

@WebServlet("/download")
public class download extends HttpServlet {


    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/x-msdownload");
        String filename = req.getParameter("fileName");
        System.out.println(filename);



        String mimeType = req.getServletContext().getMimeType(filename);
        resp.setContentType(mimeType);
        resp.setHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes("UTF-8"), "ISO8859-1"));
        resp.setContentType("library.jsp; charset=UTF-8");
        OutputStream dos = resp.getOutputStream();
        String dpath = req.getServletContext().getRealPath("file/" + filename);
        InputStream dis = new FileInputStream(dpath);
        int len = 0;
        byte[] bytes = new byte[1024 * 1024 * 5];
        while((len = dis.read(bytes)) != -1) {
            dos.write(bytes, 0, len);
        }
        dis.close();
        dos.close();
        req.getRequestDispatcher("library.jsp").forward(req,resp);

    }
}
