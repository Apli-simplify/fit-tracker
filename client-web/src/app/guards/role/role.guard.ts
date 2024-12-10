import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router } from '@angular/router';

@Injectable({
  providedIn: 'root',
})
export class roleGuard implements CanActivate {
  constructor(private router: Router) { }

  canActivate(route: ActivatedRouteSnapshot): boolean {
    const role = localStorage.getItem('user_role');

    if (route.data['roles'].includes(role)) {
      return true;
    } else {
      this.router.navigate(['/home']);
      return false;
    }
  }
}
