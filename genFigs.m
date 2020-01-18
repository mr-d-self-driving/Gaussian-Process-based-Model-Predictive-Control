close all; clear all

imgname = 'trace-without-GP';
outfile = fullfile(pwd,'/simresults/20-01-15-out-GP-without-GP.mat');
kplot = 558;

imgname = 'trace-with-GP';
outfile = fullfile(pwd,'/simresults/20-01-15-out-GP-with-GP-optimized.mat');
kplot = 412

load(outfile)


[trackdata, x0, th0, w] = RaceTrack.loadTrack_02();
track = RaceTrack(trackdata, x0, th0, w);

trackAnim = SingleTrackAnimation(track, out.mu_x_pred_opt, out.var_x_pred_opt, out.u_pred_opt, out.x_ref);
trackAnim.initTrackAnimation();
drawnow;

% k = find(~isnan(out.xhat(1,:)), 1, 'last' ) - 1;

trackAnim.mu_x_pred_opt  = out.mu_x_pred_opt;
trackAnim.var_x_pred_opt = out.var_x_pred_opt;
trackAnim.u_pred_opt     = out.u_pred_opt;
trackAnim.x_ref          = out.x_ref;
trackAnim.updateTrackAnimation(kplot); % 558


delete(trackAnim.h_car)
delete(trackAnim.h_x_ref)
delete(trackAnim.h_mu_x_pred_opt)
cellfun( @(h) delete(h), trackAnim.h_var_x_pred_opt )
legend('off')
title('')
fp.savefig(imgname,'format','epsc')