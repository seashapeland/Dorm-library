package wenjian;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet("/rename")
public class rename extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String oldfilename = req.getParameter("oldfilename");
        System.out.println(oldfilename);
        String newfilename = req.getParameter("newfilename");
        System.out.println(newfilename);
        String path = req.getServletContext().getRealPath("file/");
        File oldfile = new File(path + oldfilename);
        File newfile = new File(path + newfilename);


        HttpSession mysession = req.getSession(false);
        String uname = (String) mysession.getAttribute("username");
        String path2 = req.getServletContext().getRealPath("data/");

        File oo = new File(path2 + "file.txt");
        oo.renameTo(new File(path2 + "oldfile.txt"));

        InputStream is = new FileInputStream(req.getServletContext().getRealPath("data/oldfile.txt"));
        InputStreamReader isr = new InputStreamReader(is, "UTF-8");
        BufferedReader br = new BufferedReader(isr);
        OutputStream dos = new FileOutputStream(path2 + "file.txt",true);
        OutputStreamWriter dfw = new OutputStreamWriter(dos, "UTF-8");
        BufferedWriter dbw = new BufferedWriter(dfw);

        File temp = new File(req.getServletContext().getRealPath("data/oldfile.txt"));
        String line = "";
        String[] arrs = null;
        while ((line = br.readLine()) != null && temp.length() != 0) {
            arrs = line.split("=");
            System.out.println(arrs[0]);

            if (arrs[0].equals(oldfilename)) {
                dbw.write(newfilename + "=" + uname + "\t\n");
            } else {
                dbw.write(line + "\t\n");
            }

        }
        dbw.close();
        dfw.close();
        dos.close();
        br.close();
        isr.close();
        is.close();
        Files.delete(Paths.get(path2 + "oldfile.txt"));


        if (oldfile.renameTo(newfile)) {
            req.getRequestDispatcher("library.jsp").forward(req,resp);
        } else {
            System.out.println("失败");
        }
    }
}
