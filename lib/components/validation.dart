
 class Validation{
  var value;
  Validation({this.value});

  static emailValidation(value) {
    String raw = value.toString().trim();
    var isSpace = raw.contains(" ");
    var strSplit = raw.split('@');
    var strCount = strSplit.length;
    var findDot = strSplit.last.split('.');
    var dotCount = findDot.length;

    var domainExist = findDot.last.contains(RegExp("[a-z]"));
    if(raw.isEmpty ||raw.length<15 || strCount>2 || strCount==1 || dotCount==1 || domainExist==false || isSpace==true){
      return 'Please enter a valid email';
    }
    return null;
  }

  static passwordValidation(value){
    String raw = value.toString().trim();

    var checkPass= raw.contains(RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$"));
    if(raw.length<=6){
      return 'Please enter a password with more than 6 characters';
    }
    if(checkPass==false){
      return 'Password must contain at least a number & a uppercase letter';
    }
    return null;
  }

  static passwordConfirmValidation(value,prevpass){
    String raw = value.toString().trim();
    String rawprev = prevpass.toString().trim();

    if(raw!=rawprev || raw.isEmpty){
      return 'The passwords must match';
    }
    return null;
  }


  static nameValidation(value){
    String raw = value.toString().trim();
    List<String> nameSplit = raw.split(" ");
    int spaceCounter=0;
    for(String name in nameSplit){
        name==""?spaceCounter++:"";
    }
    bool checkName= raw.contains(RegExp(r"^[a-zA-Z\s]+$"));
    if(raw.length<=8){
      return 'Please enter your full name';
    }
    else if(checkName==false || spaceCounter>0){
      return 'Please enter a valid name';
    }
    return null;
  }

  static addressValidation(value){
    String raw = value.toString().trim();
    if(raw.length<=15 || raw.length>65){
      return 'Please enter valid address';
    }
    return null;
  }

  static dobValidation(value){
    if(value==''){
      return 'Please select you DOB';
    }
    return null;
  }
}
