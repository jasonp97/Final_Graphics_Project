import g4p_controls.*;
import java.util.*;

public class Star{
  float x;
  float y;
  
  public Star(){
    x = random(0, width);
    y = random(0, height);    
  }
}

int starsQty = 100;
int planetsQty = 0;

Star[] listOfStars;
List<Planet> listOfPlanets;


// Earth Configs
float angleEarthRevolving = 0.0;   // Angle Earth spins around its axis 
float angleEarthRotating = 0.0;    // Angle Earth moves around the Sun
float earthRevolvingSpeed = 0.05;  // Earth revolving speed around its axis 
float earthRotatingSpeed = 0.01;   // Earth rotating speed around the Sun
float earthDistanceToSun = 120;

// Moon Configs
float angleMoonRotating = 0.0;    // Angle Moon moves around the Earth
float moonRotatingSpeed = 0.01;   // Moon revolving speed around the Earth
float moonDistanceToEarth = 50;

PImage sun, earth;
PGraphics solarView;

void setup(){
  
  size(750,1000);

  background(0);
  noStroke();
  
  
  sun = loadImage("./Sun.png");
  sun.resize(200,0);
 
  earth = loadImage("./Earth.png");
  earth.resize(30,0);
  
  // This list contains all the added planets and their moons
  listOfPlanets = new ArrayList<Planet>();
  
  // This list contains all the background stars
  listOfStars = new Star[starsQty];
  
  // Generate stars
  for(int i = 0; i<starsQty; i++){
    listOfStars[i] = new Star();    
  }
  
  createGUI();
  
  solarView = new PGraphics();
  solarView = SolarView.getGraphics();
  solarView.imageMode(CENTER);
  
}

void draw(){
  background(255);
  drawMyUniverse(solarView);
}

// This function draws the solar system
void drawMyUniverse(PGraphics view){
  
  view.beginDraw();
  view.background(0);
  view.noStroke(); 
  
  /* Stars */
  view.pushMatrix();
  view.fill(255);
  for(int i = 0; i<starsQty; i++){
    view.ellipse(listOfStars[i].x, listOfStars[i].y, 2, 2);  // Draw stars
  }
  view.popMatrix();
  
  view.pushMatrix();  // For translating to the center of canvas
    view.translate(view.width/2, view.height/2);  // Translate to center of the canvas
  
    /* Sun */
    view.image(sun, 0, 0);  // Draw Sun
  
    /* Earth */
    view.pushMatrix();    
      view.rotate(angleEarthRotating);
      view.translate(earthDistanceToSun,0);  // Make a certain distance from Sun
    
      /* Moon */ 
      view.pushMatrix();         
        view.rotate(angleMoonRotating);
        view.translate(moonDistanceToEarth,0);  // Make a certain distance to the Earth
        view.fill(255);
        view.ellipse(0,0,10,10);  // Draw Moon
        angleMoonRotating += moonRotatingSpeed;  // Rotating clockwise
      view.popMatrix();
    
      //Rotate one more time around its own axis
      view.rotate(angleEarthRevolving);  
      view.image(earth, 0, 0);  // Draw Earth
      angleEarthRotating += earthRotatingSpeed;  // Rotating clockwise
      angleEarthRevolving -= earthRevolvingSpeed;  // Spinning counter-clockwise itself
    view.popMatrix();
    
    /* Planets */
    for(int i = 0; i<listOfPlanets.size(); i++){
      view.pushMatrix();
        //listOfPlanets[i].drawPlanet(view);
        listOfPlanets.get(i).drawPlanet(view);
      view.popMatrix();
    }
    
  view.popMatrix();  // For exit translating to the center of canvas
  
  view.endDraw();
}

// This function creates a new planet
void createPlanet(String planetSpecs){
  String[] listOfVal = split(planetSpecs, ',');
  
  int planetSize = Integer.parseInt(listOfVal[0].trim());
  color planetColor = createColor(listOfVal[1].trim());
  float planetRotatingSpeed = Float.parseFloat(listOfVal[2].trim());
  int distFromSun = Integer.parseInt(listOfVal[3].trim());
  boolean moonExisted = Boolean.parseBoolean(listOfVal[4].trim());
  int distMoonFromPlanet = Integer.parseInt(listOfVal[5].trim());
  float moonRotatingSpeed = Float.parseFloat(listOfVal[6].trim());
  int moonSize = Integer.parseInt(listOfVal[7].trim());
  
  Planet p = new Planet(planetSize, planetColor, planetRotatingSpeed, distFromSun, moonExisted, distMoonFromPlanet, moonRotatingSpeed, moonSize);
  
  // Add new planet to list of planets
  listOfPlanets.add(p);
  
  // Update number of planets
  planetsQty++;
}

color createColor(String desc){
  color c = #ffffff;    // Default is White
  if("green".equals(desc)){
    c = #00ff0d;
  } else if ("red".equals(desc)) {
    c = #ff0000;
  } else if ("orange".equals(desc)) {
    c = #ffbb00;
  } else if ("blue".equals(desc)){
    c = #0400ff;
  } else if ("pink".equals(desc)){
    c = #fb00ff;
  } else if ("cyan".equals(desc)){
    c = #00f7ff;
  } else if ("yellow".equals(desc)){
    c = #ddff00;
  } else if ("purple".equals(desc)){
    c = #aa00ff;
  }
  return c;
}
