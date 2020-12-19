// This class defines a planet and its moon (if existed)
public class Planet{
  int planetSize;
  color planetColor;
  float planetRotatingSpeed;
  int distFromSun;
  boolean moonExisted;
  int distMoonFromPlanet;
  float moonRotatingSpeed;
  int moonSize;
  
  float anglePlanetRotating = 0.0;
  float angleMoonRotating = 0.0;
  
  public Planet(int pSize, color pColor, float pRotSpeed, int pDist, boolean mExisted, int mDist, float mRotSpeed, int mSize){
    planetSize = pSize;
    planetColor = pColor;
    planetRotatingSpeed = pRotSpeed;
    distFromSun = pDist;
    moonExisted = mExisted;
    distMoonFromPlanet = mDist;
    moonRotatingSpeed = mRotSpeed;
    moonSize = mSize;
  }
  
  void drawPlanet(PGraphics view){
    /* Planet */
    view.pushMatrix();    
      view.rotate(anglePlanetRotating);
      view.translate(distFromSun,0);  // Make a certain distance from Sun
    
      /* Moon */
      if(moonExisted == true){                // Check if moon is existed
        view.pushMatrix();         
          view.rotate(angleMoonRotating);
          view.translate(distMoonFromPlanet,0);  // Make a certain distance to the Planet
          view.fill(255);
          view.ellipse(0,0,10,10);  // Draw Moon
          angleMoonRotating += moonRotatingSpeed/100;  // Rotating clockwise
        view.popMatrix();
      }
      
      view.fill(planetColor);
      view.ellipse(0,0,planetSize,planetSize);  // Draw Planet      
      anglePlanetRotating += planetRotatingSpeed/1000;  // Rotating clockwise
    view.popMatrix();
  }
  
}
