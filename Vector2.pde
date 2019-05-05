class Vector2 {
  
  float x;
  float y;
  
  Vector2(float newX, float newY) {
    x = newX;
    y = newY;
  }
  
  /// Adds the given v2 to this 
  void sumWith(Vector2 other) {
    x += other.x;
    y += other.y;
  }
}
