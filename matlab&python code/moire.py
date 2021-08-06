from numpy import *
import matplotlib.pyplot as plt

# Interference b/w two oblique-incident Gaussian beams
# SI Units

N = 6000 # meshgrid density
λ = 405e-9
k = (2*pi/λ)
w0 = 2e-6
zR = pi*w0**2/λ        # Rayleigh length
E0 = 11.2**3   # calibrated by the data from experiments

# x, y, z position of source, and angle in radians
# (norm) k_vector of source: (sin (theta_source_1), 0 , -1*cos (theta_source_1))
source_1_param = [-0.105, 0, 1, 6.3*(pi/180)]
source_2_param = [0.305, 0, 1, -17.3*(pi/180)]

def gaussian_beam(point, source_param):

    x_field_point, y_field_point, z_field_point = point
    x_source, y_source, z_source, theta_source = source_param
    k_x = sin(theta_source)
    k_z = -1*cos(theta_source)

    z = (x_field_point - x_source)*(k_x) + (-1*z_source)*(k_z)    # vector dot product
    r  = sqrt(1 - z**2/((x_field_point - x_source)**2 + z_source**2 + y_field_point**2))

    w = w0*sqrt(1 + (z/zR)**2)
    R = z+zR**2/z
    gouy_phase = arctan(z/zR)
    phase_factor = (k*z + k*r**2/(2*R) - gouy_phase)
    
    return E0*(w0/w)*exp(-r**2/w**2)*exp(-1j*phase_factor)
    
linRangeX = 0.02
linRangeY = 0.02

XX = linspace(-linRangeX, linRangeX, N)
YY = linspace(-linRangeY, linRangeY, N)
x,y = meshgrid(XX,YY,indexing='xy')
E_source_1 = gaussian_beam((x,y,0), source_1_param)
E_source_2 = gaussian_beam((x,y,0), source_2_param)
E = E_source_1 + E_source_2
intensity = abs(E)**2 / (2*377)

fig = plt.figure()
plt.imshow(intensity)
# plt.pcolor(x,y,intensity)
plt.rcParams["figure.figsize"] = (20,20)
plt.colorbar()
plt.show()
