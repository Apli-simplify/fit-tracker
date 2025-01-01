import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map, Observable, switchMap } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private apiUrl = 'http://localhost:8080/api';

  constructor(private httpClient: HttpClient) { }

  register(userData: {
    name: string;
    email: string;
    password: string;
    age: number;
    role: string;
    gender: string;
  }): Observable<any> {
    return this.httpClient.post(`${this.apiUrl}/users/signup`, userData);
  }

  registerAthlete(userData: {
    name: string;
    email: string;
    password: string;
    age: number;
    role: string;
    gender: string;
    weight: number;
    height: number;
    goal: string;
  }): Observable<any> {
    return this.httpClient.post(`${this.apiUrl}/athlete/signup`, userData);
  }

  login(credentials: any): Observable<any> {
    return this.httpClient.post(`${this.apiUrl}/users/signin`, credentials).pipe(
      switchMap((response: any) => {
        localStorage.setItem('access_token', response.access_token);
        localStorage.setItem('refresh_token', response.refresh_token);

        // Fetch user info after login
        return this.getUserInfo().pipe(
          map((user) => {
            localStorage.setItem('user_role', user.role);
            return user;
          })
        );
      })
    );
  }

  logout() {
    localStorage.removeItem('access_token');
    localStorage.removeItem('refresh_token');
    localStorage.removeItem('user_role');
    console.log('Logged out successfully');
  }

  refreshToken(): Observable<any> {
    const refreshToken = localStorage.getItem('refresh_token');
    return this.httpClient.post(`${this.apiUrl}/refresh`, { refresh_token: refreshToken });
  }

  getUserInfo(): Observable<any> {
    return this.httpClient.get(`${this.apiUrl}/users/user-info`);
  }

}
