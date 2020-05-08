void game() {
  background(green);
  
  int i = 0;
  while (i <objects.size()) {
    GameObject obj = objects.get(i);
    obj.act();
    obj.show();
    if (obj.isDead()) {
      objects.remove(i);
    } else {
      i++;
    }
  }
}
