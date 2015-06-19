import java.util.LinkedList;
import java.io.File;


public class AnimationFrame {
  private PVector        pos;
  private LinkedList<PImage>  frames;


  public AnimationFrame(String _folder)
  {
    int white = color(255, 255, 255);
    int white2 = color(220, 220, 220);

    frames = new LinkedList<PImage>();
    System.out.println("Loading frames from folder: " + _folder);


    File directory = new File(_folder);
    int i = 0;
    for (String s : directory.list () ) {
      println(s);

      File f = new File(s);
      String fullPath = directory.getPath() + "/" + f.getPath();
      String extension = extension(fullPath);
      if ((extension.equalsIgnoreCase("png"))) {

        println(fullPath);
        PImage img = loadImage(fullPath);
        PGraphics grid = grid(i, img.width, img.height, 0);
        if (i == 0) {
          img.loadPixels();
          for (int j = 0; j < (img.width * img.height); j++) {
            if (img.pixels[j] == white) {
              img.pixels[j] = color(255, 255, 255, 0);
            }
          }
          img.updatePixels();

          //beginRecord(PDF, _folder + "/test.pdf");
          //image(img, 0, 0);
          //endRecord();
        }

        img.mask(grid.get());
        img.loadPixels();
        for (int j = 0; j < (img.width * img.height); j++) {
          if (img.pixels[j] == white) {
            img.pixels[j] = color(255, 255, 255, 0);
          }
        }
        img.updatePixels();
        frames.add(img);

        beginRecord(PDF, _folder + "/grid.pdf");
        image(grid, 0, 0);
        endRecord();

        i += 3;
      }
    }
  }


  public void display()
  {
    for (int i = 0; i < frames.size (); i++) {
      image(frames.get(i), 0, 0);
    }
  }


  private String extension(String _filePath)
  {
    int dot = _filePath.lastIndexOf('.');
    return _filePath.substring(dot + 1);
  }


  private PGraphics grid(int offset, float _width, float _height, int alpha)
  {
    PGraphics g = createGraphics((int) _width, (int) _height);
    g.beginDraw();
    g.background(255, alpha);
    g.fill(0);
    for (int i = -100; i < _height + 200; i += 22) {
      if (i % 7 == 0) {
        g.rect(0, offset + i, _width, 18);
      } else {
        g.rect(0, offset + i, _width, 18);
      }
    }
    g.endDraw();
    return g;
  }
}

