import { Component, OnInit } from '@angular/core';
import { JsSIP } from 'jssip';
@Component({
  selector: 'app-cabinet-login',
  templateUrl: './work-space.component.html',
  styleUrls: ['./work-space.component.css']
})
export class WorkSpaceComponent implements OnInit {

  socket = new JsSIP.WebSocketInterface('wss://sip.myhost.com');

  constructor() { }

  ngOnInit() {

  }


  login() {

  }
}
