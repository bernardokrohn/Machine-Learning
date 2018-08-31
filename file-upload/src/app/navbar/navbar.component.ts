import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})

// Adding responsiveness to Navbar since we don't use Bootstrap's javascript component
export class NavbarComponent implements OnInit {

  public isCollapsed = true;

  constructor() { }

  ngOnInit() {
  }

  toggleMenu() {
    this.isCollapsed = !this.isCollapsed;
  }
}
