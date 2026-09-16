"""Original educational schematics, not thesis results or Navier-Stokes simulations."""
from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon, FancyArrowPatch

OUT=Path(__file__).parent/'assets'
plt.rcParams.update({'font.family':'DejaVu Sans','font.size':12,'axes.spines.top':False,'axes.spines.right':False,'axes.labelcolor':'#28343b','text.color':'#28343b','xtick.color':'#47545b','ytick.color':'#47545b','axes.edgecolor':'#aab4b8','savefig.facecolor':'#ffffff'})
TEAL='#087f8c'; MAROON='#8c2946'; GOLD='#b56c19'
def save(fig,name):
 fig.savefig(OUT/(name+'.png'),dpi=180,bbox_inches='tight',facecolor='white')
 fig.savefig(OUT/(name+'.svg'),bbox_inches='tight',facecolor='white')
 plt.close(fig)

fig,ax=plt.subplots(figsize=(9,6.5))
q=np.linspace(-1.5,1.5,9); X,Y=np.meshgrid(q,q)
ax.quiver(X,Y,-Y,X,color=TEAL,alpha=.65,angles='xy',scale_units='xy',scale=6,width=.004)
t=np.linspace(0,2*np.pi,300)
ax.plot(np.cos(t),np.sin(t),color='#bbc6ca',lw=1.2,ls='--')
ax.scatter([1],[0],s=70,color=MAROON,zorder=5)
ax.annotate('',(1,.8),(1,0),arrowprops={'arrowstyle':'->','color':MAROON,'lw':3})
ax.annotate('',(.18,0),(1,0),arrowprops={'arrowstyle':'->','color':GOLD,'lw':3})
ax.text(1.09,.53,'Velocity',color=MAROON,fontsize=12)
ax.text(.19,-.2,'Acceleration',color=GOLD,fontsize=12)
ax.set(xlim=(-1.9,1.9),ylim=(-1.8,1.8),aspect='equal',xlabel='Horizontal position x (arbitrary units)',ylabel='Vertical position y (arbitrary units)')
ax.set_title('A steady field can still accelerate a moving particle',loc='left',fontsize=17,pad=22,fontweight='bold')
fig.text(.13,.005,'Illustration: u(x, y) = (−y, x). The field stays fixed; a particle changes direction.',fontsize=11)
fig.tight_layout(rect=(0,.04,1,1));save(fig,'velocity-field')

fig,ax=plt.subplots(figsize=(10,6))
ax.set_xlim(0,10);ax.set_ylim(-6.3,.65);ax.axis('off')
ax.add_patch(Polygon([(0,0),(3,0),(9,-5.6),(8.5,-6.15),(2.7,-.55),(0,-.55)],facecolor='#7496ad',edgecolor='#48697f',lw=1.5))
ax.add_patch(Polygon([(3.5,0),(10,0),(10,-.85),(4.5,-.85)],facecolor='#dbd3c4',edgecolor='#9c9282',lw=1.5))
ax.add_patch(Polygon([(4.0,-.92),(10,-.92),(10,-5.4),(9.1,-5.4)],facecolor='#fbecd7',edgecolor='none'))
ax.text(.2,.22,'Oceanic plate',fontsize=13,fontweight='bold')
ax.text(6.0,.22,'Overriding plate',fontsize=13,fontweight='bold')
ax.text(6.2,-2.15,'Mantle wedge',fontsize=16,fontweight='bold')
ax.text(6.2,-2.58,'Slow deformation over geological time',fontsize=10)
ax.text(3.8,-4.15,'Subducting slab',rotation=-42,fontsize=13,color='#48697f')
ax.add_patch(FancyArrowPatch((.7,-.25),(2.3,-.25),arrowstyle='->',mutation_scale=20,lw=2,color='#284c65'))
ax.add_patch(FancyArrowPatch((4.7,-1.85),(6.5,-3.55),arrowstyle='->',mutation_scale=20,lw=2,color='#284c65'))
ax.add_patch(FancyArrowPatch((8.8,-1.4),(5.65,-1.2),connectionstyle='arc3,rad=.15',arrowstyle='->',mutation_scale=18,lw=2,color=TEAL))
ax.add_patch(FancyArrowPatch((5.7,-1.4),(8.15,-4.25),connectionstyle='arc3,rad=.2',arrowstyle='->',mutation_scale=18,lw=2,color=TEAL))
ax.text(7.0,-4.95,'Illustrative flow directions',color=TEAL,fontsize=11)
ax.set_title('Where Stokes equations meet the Earth',loc='left',fontsize=18,fontweight='bold',pad=15)
fig.text(.125,.03,'Conceptual cross-section only. Not to scale; not a computed flow field or a thesis result.',fontsize=11)
fig.tight_layout(rect=(0,.06,1,1));save(fig,'mantle-wedge')

fig,ax=plt.subplots(figsize=(10,6))
x=np.linspace(-2.8,2.8,6001)
for s,c,style in [(0.8,TEAL,'-'),(.3,GOLD,'--'),(.08,MAROON,'-.')]:
 y=(np.pi*s*s)**(-.25)*np.exp(-x*x/(2*s*s))
 ax.plot(x,y,label=f'Width σ = {s:g}',color=c,lw=2.6,ls=style)
 integral=np.trapezoid(y*y,x)
 assert abs(integral-1)<1e-5
ax.set(xlim=(-2.5,2.5),ylim=(0,2.9),xlabel='Position x (arbitrary units)',ylabel='Function value fσ(x) (arbitrary units)')
ax.set_title('Same squared integral. Taller and narrower peaks.',loc='left',fontsize=18,pad=20,fontweight='bold')
ax.legend(frameon=False,loc='upper left',fontsize=12)
ax.grid(axis='y',alpha=.18)
ax.text(.98,.92,'Each curve has ∫ fσ² dx = 1',transform=ax.transAxes,ha='right',fontsize=12)
fig.text(.125,.02,'A one-dimensional function example, not a fluid simulation or a Navier-Stokes solution.',fontsize=11)
fig.tight_layout(rect=(0,.06,1,1));save(fig,'bounded-energy-peaks')
print('Created 3 original figures in PNG and SVG; squared integrals checked numerically.')
