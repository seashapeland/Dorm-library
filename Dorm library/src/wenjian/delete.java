package wenjian;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet("/delete")
public class delete extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String deletefilename = req.getParameter("deletefilename");
        String path = req.getServletContext().getRealPath("file/");
        Files.delete(Paths.get(path + deletefilename));

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

            if (!arrs[0].equals(deletefilename)) {
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
        req.getRequestDispatcher("library.jsp").forward(req,resp);
    }
}
