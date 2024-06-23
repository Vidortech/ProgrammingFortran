program cfd_simulator
  implicit none
  integer, parameter :: nx = 50, ny = 50
  integer, parameter :: nt = 1000
  real, parameter :: dx = 0.01, dy = 0.01
  real, parameter :: dt = 0.001
  real, parameter :: rho = 1.0, nu = 0.1
  real :: u(nx, ny), v(nx, ny), p(nx, ny)
  real :: un(nx, ny), vn(nx, ny), pn(nx, ny)
  integer :: i, j, n
  
  ! Initialize velocity and pressure fields
  u = 0.0
  v = 0.0
  p = 0.0
  
  ! Time-stepping loop
  do n = 1, nt
    un = u
    vn = v
    pn = p
    
    ! Compute tentative velocity field
    do j = 2, ny-1
      do i = 2, nx-1
        u(i,j) = un(i,j) + dt * ( &
          - un(i,j) * (un(i,j) - un(i-1,j)) / dx &
          - vn(i,j) * (un(i,j) - un(i,j-1)) / dy &
          - (p(i+1,j) - p(i-1,j)) / (2.0 * dx) / rho &
          + nu * ((un(i+1,j) - 2.0 * un(i,j) + un(i-1,j)) / dx**2 &
          + (un(i,j+1) - 2.0 * un(i,j) + un(i,j-1)) / dy**2) )

        v(i,j) = vn(i,j) + dt * ( &
          - un(i,j) * (vn(i,j) - vn(i-1,j)) / dx &
          - vn(i,j) * (vn(i,j) - vn(i,j-1)) / dy &
          - (p(i,j+1) - p(i,j-1)) / (2.0 * dy) / rho &
          + nu * ((vn(i+1,j) - 2.0 * vn(i,j) + vn(i-1,j)) / dx**2 &
          + (vn(i,j+1) - 2.0 * vn(i,j) + vn(i,j-1)) / dy**2) )
      end do
    end do
    
    ! Apply boundary conditions for u and v
    u(1,:) = 0.0
    u(nx,:) = 0.0
    u(:,1) = 0.0
    u(:,ny) = 1.0
    v(1,:) = 0.0
    v(nx,:) = 0.0
    v(:,1) = 0.0
    v(:,ny) = 0.0
    
    ! Solve for pressure field
    do j = 2, ny-1
      do i = 2, nx-1
        p(i,j) = (pn(i+1,j) + pn(i-1,j)) * dy**2 + &
                 (pn(i,j+1) + pn(i,j-1)) * dx**2
        p(i,j) = p(i,j) - rho * dx**2 * dy**2 / &
                 (2.0 * (dx**2 + dy**2)) * &
                 ((un(i+1,j) - un(i-1,j)) / (2.0 * dx) + &
                  (vn(i,j+1) - vn(i,j-1)) / (2.0 * dy))
      end do
    end do
    
    ! Apply boundary conditions for pressure
    p(1,:) = p(2,:)
    p(nx,:) = p(nx-1,:)
    p(:,1) = p(:,2)
    p(:,ny) = p(:,ny-1)
  end do

  ! Output results
  open(unit=10, file='velocity.dat', status='unknown')
  do j = 1, ny
    do i = 1, nx
      write(10,*) i*dx, j*dy, u(i,j), v(i,j)
    end do
  end do
  close(10)

  print *, 'Simulation complete. Results written to velocity.dat'
  
end program cfd_simulator


