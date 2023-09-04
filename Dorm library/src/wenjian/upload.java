package wenjian;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/upload")
public class upload extends HttpServlet {


    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        try {
            DiskFileItemFactory dff = new DiskFileItemFactory();
            ServletFileUpload ul = new ServletFileUpload(dff);
            //String uname2 = new String(req.getParameter("username").getBytes("iso-8859-1"), "utf-8");
            //System.out.println(uname2);
            HttpSession mysession = req.getSession(false);
            String uname = (String) mysession.getAttribute("username");
            System.out.println(uname);
            List<FileItem> wenlist = ul.parseRequest(req);
//            Map<String,String> filemap = new HashMap<>();
            for (FileItem fi : wenlist) {
                if (!fi.isFormField()) {
                    String filename = fi.getName();
                    Long filesize = fi.getSize();
                    System.out.println(filename + "++" + filesize);
                    InputStream is = fi.getInputStream();
                    String path = req.getServletContext().getRealPath("file/" + filename);
                    String path2 = req.getServletContext().getRealPath("data/file.txt");
                    System.out.println(path);

                    OutputStream os = new FileOutputStream(path);
                    OutputStream dos = new FileOutputStream(path2,true);
                    OutputStreamWriter dfw = new OutputStreamWriter(dos, "UTF-8");
                    BufferedWriter dbw = new BufferedWriter(dfw);
                    dbw.write(filename + "=" + uname + "\t\n");
                    int len = 0;
                    byte[] bytes = new byte[1024 * 1024 * 5];
                    while((len = is.read(bytes)) != -1) {
                        os.write(bytes, 0, len);
                    }
                    dbw.close();
                    dfw.close();
                    dos.close();
                    os.close();
                    is.close();

                }
            }
            req.getRequestDispatcher("library.jsp").forward(req, resp);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }

//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//        }

    }
}
