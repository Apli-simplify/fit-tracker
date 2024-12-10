import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';

import { catchError, switchMap } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { AuthService } from '../../services/auth/auth.service';

@Injectable()
export class authInterceptor implements HttpInterceptor {
  constructor(private authService: AuthService) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const token = localStorage.getItem('access_token');
    let clonedReq = req;

    if (token) {
      clonedReq = req.clone({
        setHeaders: {
          Authorization: `Bearer ${token}`,
        },
      });
    }

    return next.handle(clonedReq).pipe(
      catchError((error) => {
        if (error.status === 401) {
          // Token expired, refresh it
          return this.authService.refreshToken().pipe(
            switchMap((response) => {
              localStorage.setItem('access_token', response.access_token);
              const newReq = req.clone({
                setHeaders: {
                  Authorization: `Bearer ${response.access_token}`,
                },
              });
              return next.handle(newReq);
            })
          );
        }
        return throwError(() => error)
      })
    );
  }
}
