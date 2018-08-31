import { Component, OnInit, Input } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { fromEvent } from '../../../node_modules/rxjs';

@Component({
  selector: 'app-upload',
  templateUrl: './upload.component.html',
  styleUrls: ['./upload.component.css'],
})

export class UploadComponent implements OnInit {

  selectedFile: File = null;

  localUrl: any[];

  pickAble: boolean = true;

  canSubmit: boolean = true;

  invalidImg: boolean = false;

  submitted: boolean = false;

  done: boolean = false;

  prediction: string = "";

  msg: string = "";

  // Service is necessary for POST request in onUpload(). Needs importing (see above)
  constructor(private http: HttpClient) { }

  ngOnInit() {
  }

  // Get local name from image
  getName(){
    if(this.selectedFile != null){
      return this.selectedFile.name;
    } else{ return ""; }
  }

  // Reset variables
  reset(){
    this.selectedFile = null;
    this.localUrl = null;
    this.pickAble = true;
    this.canSubmit = true;
    this.invalidImg = false;
    this.submitted = false; 
    this.done = false;
    this.prediction = "";
    this.msg = "";
  }

  validate(event){
    if(event.target.files && event.target.files[0]){
      var component = this;
      var fr = new FileReader();

      fr.onload = function() { // file is loaded
          var img = new Image;

          img.onload = function() {
              if(img.width < 400 || img.height < 400){
                component.invalidImg = true;
              } else{
                component.processImage(event)
              }
          };

          img.src = fr.result; // is the data URL because called with readAsDataURL
      };

      fr.readAsDataURL(event.target.files[0]);
    }
  }

  processImage(event){
    this.selectedFile = <File>event.target.files[0];
    this.showPreviewImage(event);
    this.pickAble = false;
  }

  // Image preview
  showPreviewImage(event: any) {
    // Gets image file from event
    if (event.target.files && event.target.files[0]) {
        var reader = new FileReader();

        reader.onload = (event: any) => {
          // Get target (place to insert image)
          this.localUrl = event.target.result;
        }
        
        // Reads the data from image as a URL
        reader.readAsDataURL(event.target.files[0]);
    }
  }

  setPrediction(res){
    let result = res["stdout"].slice(-2);

    if(parseInt(result) !== 0){
      this.msg = "Abnormal values: visit your ophthalmologist as soon as possible!"
    } else{
      this.msg = "Normal values: make sure to redo exam next year."
    }

    this.prediction = result;
  }

  onUpload(){
    this.canSubmit = false;
    this.submitted = true;
    let fd = new FormData();
    fd.append('eyeImage', this.selectedFile, this.selectedFile.name);
    
    /*
    Make a POST request to /upload
    Currently we have localhost:3000, where server is located
    This should be changed when deploying to match the server's location
    */
    this.http.post('http://localhost:3000/upload', fd).subscribe(res => {
      // What to do with the server's response
      console.log(res["stdout"]);
      this.done = true;
      this.setPrediction(res);
    });
  }

}
