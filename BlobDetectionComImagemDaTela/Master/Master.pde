import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.AWTException;
 
PImage screenshot;
color trackColor; 
float threshold = 20;
float distThreshold = 28;
 
 
 ArrayList<Blob> blobs = new ArrayList<Blob>();
 
void setup() {
// valor da tela principal size(1366, 768);
  size(600, 400);
  frame.removeNotify();
  trackColor = color(255, 0, 0);
}

void keyPressed() {
  if (key == 'a') {
    distThreshold++;
  } else if (key == 'z') {
    distThreshold--;
  }
  println(distThreshold);
}

void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*screenshot.width;
  trackColor = screenshot.pixels[loc];
}

void draw() {
  screenshot();
  image(screenshot, 0, 0, width, height);
    //threshold = map(mouseX, 0, width, 0, 100);
 
  blobs.clear();

  //threshold = map(mouseX, 0, width, 0, 100);
  threshold = 80;

  // Begin loop to walk through every pixel
  for (int x = 0; x < screenshot.width; x++ ) {
    for (int y = 0; y < screenshot.height; y++ ) {
      int loc = x + y * screenshot.width;
      // What is current color
      color currentColor = screenshot.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {

        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      }
    }
  }

 for (Blob b : blobs) {
    if (b.size() > 500) {
      b.show();
    }
    }
  }
  

float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

 
void screenshot() {
  try {
    Robot robot = new Robot();
//original screenshot = new PImage(robot.createScreenCapture(new Rectangle(0,0,600, 400)));

    screenshot = new PImage(robot.createScreenCapture(new Rectangle(770,370,600, 400)));
  } catch (AWTException e) { }
}
