
class Fairy {
  
  boolean debug = false;
  Vector2 pos;
  float forwardVel = 0;
  float angle = 0;
  float size = 5;
  float distTravelled = 0;
  float distOffset = 0;
  float turnMin = 5;
  float turnMax = 20;
  float erraticness = .005;
  float synchPower = 1;
  color myColor;
  color defaultColor;
  color influenceColor;
  int bounceBuffer = 0;
  ArrayList<Vector2> trail = new ArrayList<Vector2>();
  int maxTrail = 20;
  int framesElapsed = 0;
  float myHue = 0;
  float totalInfluence = 0;
  
  
  Fairy(Vector2 startPos) {
    
    pos = startPos;
    forwardVel = random(.2, 1);
    angle = random(0, 360);
    distOffset = random(-500, 500);
    size = random(5, 20);
    myHue = random(0, 100);
    defaultColor = color(myHue, 30, 15);
    influenceColor = color(myHue, 30, 100);
    myColor = defaultColor;
  }
  

  void update(Fairy[] allFairies) {
    
    float actualForwardVel = forwardVel * (1 + totalInfluence);
    
    //move the fairy forward at the current angle
    distTravelled += actualForwardVel;
    
    // calculate new angle
    float turnPower = lerp(turnMin, turnMax, totalInfluence);
    float deltaAngle = noise((distTravelled + distOffset)* erraticness) - .5;
    deltaAngle *= turnPower;
    angle += deltaAngle;
    if (angle >= 360) angle -= 360;
    if (angle <= 0) angle += 360;
    
    //boundary();
    if (bounceBuffer > 0) bounceBuffer--;
    
    if (debug) drawDebugInfo();
    
    synch(allFairies);
    
    // move the fairy forward
    Vector2 delta = VectorFromAngle(angle);
    pos.sumWith(new Vector2(delta.x * actualForwardVel, delta.y * actualForwardVel));
    
    // add the position to the trail
    if (framesElapsed % 6 == 0)
      trail.add(new Vector2(pos));
    if (trail.size() > maxTrail) {
      trail.remove(0);
    }
    renderTrail();
 
    noStroke();
    fill(myColor);
    ellipse(pos.x, pos.y, size, size);
    
    framesElapsed++;
  }
  
  void boundary() {
    if (pos.x < 0) pos.x = width;
    if (pos.x > width) pos.x = 0;
    if (pos.y < 0) pos.y = height;
    if (pos.y > height) pos.y = 0;
  }
  
  
  
  void synch(Fairy[] allFairies) {
    
    totalInfluence = 0;
    
    for (Fairy other : allFairies) {
      
      if (other == this) continue;
      if (other == null) continue;
      
      float distToFairy = dist(other.pos.x, other.pos.y, pos.x, pos.y);
      if ( distToFairy > synchDistance) continue;
        
      // get the degree of influence based on how close they are
      float influence = (synchDistance - distToFairy)/synchDistance;
      totalInfluence += influence * .3;
      
      stroke(255, 0, 255, 20 * influence);
      line(pos.x, pos.y, other.pos.x, other.pos.y);
      
    }
    
    myColor = lerpColor(defaultColor, influenceColor, totalInfluence);
  }
  
  
  void renderTrail() {
    
    for (int i = 0; i < trail.size(); i++) {
      
      Vector2 trailPt = trail.get(i);
      if (trailPt == null) continue;
      float amt = (float)i / trail.size();
      stroke(influenceColor, amt * 100);
      int j = i - 1;
      if (j >= 0) {
        Vector2 trailPt2 = trail.get(j);
        
        // fairies can teleport across boundaries as if it's looping, so this makes sure we dont render a trail across the whole screen
        if (dist(trailPt.x, trailPt.y, trailPt2.x, trailPt2.y) < 50)
        line(trailPt.x, trailPt.y, trailPt2.x, trailPt2.y);
      }
    }
  }
  
  
  
  void drawDebugDirection(float x, float y) {
    stroke(0);
    float debugLineSize = 50;
    line(pos.x, pos.y, pos.x + x * debugLineSize, pos.y + y * debugLineSize);
  }
  
  void drawDebugInfo() {
    // display properties
    fill(100);
    textSize(10);
    text("angle:" + angle, pos.x + size, pos.y); 
    text("dist:" + distTravelled, pos.x + size, pos.y + 20);
  }
}
