import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-cabinet-login',
  templateUrl: './work-space.component.html',
  styleUrls: ['./work-space.component.css']
})
export class WorkSpaceComponent implements OnInit {

  telephone: string = "";

  constructor() { }

  ngOnInit() {

  }

  login() {

  }

  click_Digits(digit: number) {
    console.log(digit)
    this.telephone += digit.toString();
  }
}
