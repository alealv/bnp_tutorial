# Illustration of GEM draws.
# Copyright (C) 2015, Tamara Broderick
# www.tamarabroderick.com

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# max looping
max_iters = 1000

# log remainder (when generating GEM distribution)
# since can't generate an actual infinity of beta random vars
# (log base e)
max_log_remainder = -20

ex5_draw_gem <- function(alpha) {
# Samples and illustrates GEM random distributions.
#
# Args:
#  alpha: the GEM parameter
#
# Returns:
#  Nothing
#
# For each press of "enter" samples a GEM random element
# and illustrates it as a partition of the unit interval.
# Press 'x' when finished making draws.

        # set up the figure for a very horizontal plot
        par(mar = rep(2,4))
        layout(matrix(c(1,2,3), 3, 1, byrow=TRUE),
                heights=c(2,1,2)
                )

	for(iter in 1:max_iters) {

	# initializations
	rho = c() # GEM-generated probabilities
	csum = c(0)  # cumulative sums of probs gen'd so far
	bar_colors = c()

 	# make the GEM draw
	log_remainder = 0
	while(log_remainder > max_log_remainder) {
		# beta stick-break
		V = rbeta(1,1,alpha)
		# mass resulting from stick break
		newrho = exp(log_remainder)*V

		# update list of instantiated probabilities
		rho = rbind(rho,newrho)
		log_remainder = log_remainder + log(1-V)
		csum = rbind(csum,1-exp(log_remainder))
		bar_colors = c(bar_colors, "grey")
	}

	# white space above bar plot
	plot(0, type="n", xlab="", ylab="", axes=FALSE)

	# bar plot makes it easy to plot
	# probabilities one after another
	barplot(rbind(rho,exp(log_remainder)),
		beside=FALSE,
                horiz=TRUE,
                col=bar_colors,
		width=0.7,
		ylim=c(0,1),
		main=bquote(rho~"~GEM("~.(alpha)~")"),
		cex.main=2.5
	)

	# white space below bar plot
	plot(0, type="n", xlab="", ylab="", axes=FALSE)
	
	# Generate a new draw for each press of "enter"
        # Press 'x' when finished
	line <- readline()
	if(line == "x") {
		dev.off()
		return("done")
	}
	}
}	


